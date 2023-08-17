//
//  Network.swift
//  SafeMe
//
//  Created by Temur on 21/07/2023.
//

import Foundation
extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
class Network {
    static let shared = Network()
    private init() {}
    func generateBoundaryString() -> String { return "Boundary-" + UUID().uuidString }

    struct Parsing:Decodable {let success: Bool; let message:String?}
    
    private func parsing(_ data:Data) -> String? {
        do {
            let object = try JSONDecoder().decode(Parsing.self, from: data)
            return object.success ? nil :object.message
        }
        catch {
            return nil
        }
    }
    
    func push<T: Decodable>(_ token:Bool = true,
                            api:Api,
                            body:Data?,
                            headers:[String:String]?,
                            type: T.Type,
                            completion:@escaping(Result<T>) -> ())
    {
        var request = URLRequest(url: URL(string: api.path)!,timeoutInterval: 15)
        request.httpMethod = api.method
        request.httpBody = body
        if let headers = headers {
            headers.forEach { request.addValue($0.key, forHTTPHeaderField: $0.value) }
        }
        
        if token, let value = AuthApp.shared.token {
            request.addValue("Bearer " + value, forHTTPHeaderField: "Authorization")
        }
        
        for value in DeviceHeader.headerArray {
            request.addValue(value.value, forHTTPHeaderField: value.key)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
 
            guard let response = response as? HTTPURLResponse, let data = data else { return
                completion(Result.failure(error: StatusCode(error))) }
            let code = response.statusCode
            
            if code == 401 {
                return self.refreshAuthorization(api: api, body: body, headers: headers, type: type, completion: completion)
            }
            
            if let object = try? JSONDecoder().decode(Parsing.self, from: data), !object.success {
                let errorCode = code == 200 ? 400 : code
                return completion(Result.failure(error: StatusCode(code: errorCode, message: object.message)))
            }

            guard let value = try? JSONDecoder().decode(type.self, from: data) else {
                print("-----------------------")
                print(api.path)
                print("\n")
                print(type.self)
                print("\n")
                print(String(data: data, encoding: .utf8)!)
                print("-----------------------")
                return completion(Result.failure(error: StatusCode(code: code, message: error?.localizedDescription)))
            }
            
            
            
            switch code {
            case ...499: return completion(Result.success(model: value))
            default: return completion(Result.failure(error: StatusCode(code: code, message: error?.localizedDescription)))
            }
        }
        task.resume()
    }
    
    private func refreshAuthorization<T: Decodable>
    (
        api:Api,
        body:Data?,
        headers:[String:String]?,
        type: T.Type,
        completion:@escaping(Result<T>) -> ()
    )
    {
        let authApp = AuthApp.shared
        guard let refresh = authApp.tokenRefresh else {return
            completion(Result.failure(error: StatusCode.init(code: 411, message: "Your authorization is outdated. Login again to the app".localizedString)))}
        
        //Api
        let apiRefresh = Api.authRefresh
        
        let url = URL(string: apiRefresh.path)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [ "refresh": refresh ]
        request.httpBody = parameters.percentEncoded()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else {                                                               // check for fundamental networking error
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                completion(Result.failure(error: StatusCode.init(code: response.statusCode, message: "Reenter to the app. Your authorization is expired".localizedString)))
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(AuthToken.self, from: data)
                print(responseObject)
                guard let token = responseObject.body?.token else {
                    authApp.token = nil
                    authApp.tokenRefresh = nil
                    authApp.appEnterCode = nil
                    return completion(Result.failure(error: StatusCode.init(code: 411, message: "Your authorization is outdated".localizedString)))
                }
                authApp.token = token
                authApp.tokenRefresh = responseObject.body?.refresh
                return self.finishPush(token, api: api, body: body, headers: headers, type: type, completion: completion)
            } catch {
                print(error) // parsing error
                authApp.token = nil
                authApp.tokenRefresh = nil
                authApp.appEnterCode = nil
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(responseString)")
                } else {
                    print("unable to parse response as string")
                }
            }
        }
        
        task.resume()
    }
    
    
    private func finishPush<T: Decodable>(_ token:String? = nil/*AuthApp().token*/,
                            api:Api,
                            body:Data?,
                            headers:[String:String]?,
                            type: T.Type,
                            completion:@escaping(Result<T>) -> ())
    {
        var request = URLRequest(url: URL(string: api.path)!,timeoutInterval: Double.infinity)
        request.httpMethod = api.method
        request.httpBody = body
        request.timeoutInterval = 10
       
        if let headers = headers {
            headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        }
        if let token = token {
            request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        }
        
        for value in DeviceHeader.headerArray {
            request.addValue(value.value, forHTTPHeaderField: value.key)
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, let data = data else { return completion(Result.failure(error: StatusCode(error))) }
            let code = response.statusCode
           
            print(String(data: data, encoding: .utf8)!)
 
            switch code {
            case 401: return completion(Result.failure(error: StatusCode(code: 401, message: "Your authorization is outdated".localizedString)))
            
            case 200...299:
                if let string = self.parsing(data) {
                    return completion(Result.failure(error: StatusCode(code: 400, message: string)))}
                guard let object = try? JSONDecoder().decode(type.self, from: data) else {
                    print(String(data: data, encoding: .utf8)!)
                    return completion(Result.failure(error: StatusCode(code: 404, message: "Error in the data received from the server".localizedString)))
                }
                return completion(Result.success(model: object))
            case 500...: return completion(Result.failure(error: StatusCode(code: code)))
                
            default:
                return completion(Result.failure(error: StatusCode(code: code, message: error?.localizedDescription)))
            }
        }
        task.resume()
    }
    
    
    //MARK: - отправка фоторгафий с дополнительными параметрами в form/data
    func generateMutableData(boundary:String, parameters: [[String : String]], imagesData:[Data]) -> NSMutableData {
        let mimeType = "image/jpg"
        let body = NSMutableData()
        
        for param in parameters {
            if param["disabled"] == nil {
                let paramName = param["key"]!
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition:form-data; name=\"\(paramName)\"")
                
                if param["contentType"] != nil { body.appendString("\r\nContent-Type: \(param["contentType"] ?? "")") }
                let paramType = param["type"]
                
                if paramType == "text" {
                    let paramValue = param["value"] ?? ""
                    body.appendString("\r\n\r\n\(paramValue)\r\n")
                }
            }
        }
        
        // если есть фотографии
        if !imagesData.isEmpty {
            for (row, data) in imagesData.enumerated() {
                let string = UUID().uuidString + Date().toString("yyyyMMddHHmm")
                let filename = string + "-\(row).jpg"
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition:form-data; name=\"image[]\"; filename=\"\(filename)\"\r\n")
                body.appendString("Content-Type: \(mimeType)\r\n\r\n")
                body.append(data)
                body.appendString("\r\n")
            }
        }
        
        body.appendString("--\(boundary)--\r\n")
        return body
    }
    
}
