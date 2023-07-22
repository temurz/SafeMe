//
//  ResponseModel.swift
//  SafeMe
//
//  Created by Temur on 21/07/2023.
//

import Foundation
struct ResponseModel<T: Decodable>:Decodable {
    let error:Bool?         // true - ошибка false - запрос выполнен без ошибок
    let message:String?     // текст об ошибке
    let page: Int?          // текущая страница
    let countPage: Int?     // количество обектов на странице
    let max_page: Int?      // максимальное количество страниц
    let result: T           // данные в запросе
}

struct PageInfo {
    var page: Int?
    let countPage: Int?
    let max_page: Int?
}
