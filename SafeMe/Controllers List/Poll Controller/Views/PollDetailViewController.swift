//
//  PollDetailViewController.swift
//  SafeMe
//
//  Created by Temur on 18/08/2023.
//

import UIKit
class PollDetailViewController: GradientViewController {
    private let contentView = UIView(.white, radius: 12)
    private let scrollView = UIScrollView()
    private let mainImageView = UIImageView()
    private let titleLabel = UILabel()
    private let tableView = UITableView(.clear)
    private let saveButton = UIButton(backgroundColor: .custom.buttonBackgroundColor, textColor: .white, text: "Save".localizedString, radius: 8)
    
    private let presenter = PollDetailViewPresenter()
    
    var items: [Answer] = []
    var selectedItem: Answer?
    var model: PollingModel
    
    init(model: PollingModel) {
        self.model = model
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getAnswers(poll_id: model.id)
        
    }
    
    private func initialize() {
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, view: contentView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: contentView, array: [scrollView, saveButton])
        scrollView.backgroundColor = .white
        scrollView.layer.cornerRadius = 12
        SetupViews.addViewEndRemoveAutoresizingMask(superView: scrollView, array: [mainImageView, titleLabel, tableView])
        
        mainImageView.layer.cornerRadius = 12
        mainImageView.contentMode = .scaleAspectFit
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PollAnswerCell.self, forCellReuseIdentifier: "AnswerCell")
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        
        mainImageView.sd_setImage(with: URL(string: model.media))
        titleLabel.text = model.text
        titleLabel.numberOfLines = 0
        
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -16),
            scrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.82),
            mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 0.4),
            
            titleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -16)
        ])
    }
    
    @objc private func saveAction() {
        if let selectedItem = selectedItem {
            presenter.saveAnswer(question: model.id, answer: selectedItem.id)
        }else {
            alert(error: StatusCode(code: 0, message: "Please choose an answer!".localizedString), action: nil)
        }
        
    }
}

extension PollDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell") as! PollAnswerCell
        cell.updateModel(text: items[indexPath.row].text)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = items[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! PollAnswerCell
        cell.selectCell(true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PollAnswerCell
        cell.selectCell(false)
    }
}

extension PollDetailViewController: PollDetailViewPresenterProtocol {
    func reloadAnswers(_ answers: [Answer]) {
        if answers.isEmpty {
            alert(error: StatusCode(code: 0, message: "Sorry there are no answers for this question!".localizedString)) { [weak self] _ in
                guard let self else { return }
                self.navigationController?.popViewController(animated: true)
            }
            return
        }
        self.items = answers
        self.tableView.reloadData()
    }
    
    func savedSuccessfully(_ statusCode: StatusCode) {
        self.alert(error: statusCode) { [weak self] _ in
            guard let self else { return }
            self.navigationController?.popViewController(animated: true)
        }
    }
}
