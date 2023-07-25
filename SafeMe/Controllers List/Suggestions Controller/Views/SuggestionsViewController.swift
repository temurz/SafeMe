//
//  ViewController.swift
//  SafeMe
//
//  Created by Temur on 14/07/2023.
//

import UIKit
import SideMenu

class SuggestionsViewController: BaseViewController {
    let bgFilterView = UIView(.clear)
    private var ageFilterCollectionView: UICollectionView!
    private var separatorLine = UIView(.custom.gray)
    private var categoriesView = CategoriesView()
    private var items = [("0-11 yoshlar", true), ("0-3 yoshlar", false),("0-5 yoshlar", false), ("0-7 yoshlar", false), ("0-9 yoshlar", false)]
    
    override func loadView() {
        super.loadView()
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .custom.mainBackgroundColor
        navBarTitleLabel.text = "Tavsiyalar"
        leftMenuButton.tag = 0
        ageFilterCollectionView.backgroundColor = .clear
        setupConstraints()
    }
    
    private func initialize() {
        let ageFilterLayout = UICollectionViewFlowLayout()
        ageFilterLayout.itemSize = CGSize(width: 120, height: 50)
        ageFilterLayout.scrollDirection = .horizontal
        ageFilterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: ageFilterLayout)
        ageFilterCollectionView.showsHorizontalScrollIndicator = false
        
        ageFilterCollectionView.dataSource = self
        ageFilterCollectionView.delegate = self
        
        ageFilterCollectionView.register(AgeFilterCell.self, forCellWithReuseIdentifier: "AgeCell")
        SetupViews.addViewEndRemoveAutoresizingMask(superView: bgFilterView, view: ageFilterCollectionView)
        SetupViews.addViewEndRemoveAutoresizingMask(superView: view, array: [bgFilterView, categoriesView])
        
//        bgFilterView.layer.shadowColor = UIColor.black.cgColor
//        bgFilterView.layer.shadowOpacity = 1
//        bgFilterView.layer.shadowOffset = CGSize(width: 0, height: -3)
//        bgFilterView.layer.shadowRadius = -15
//        bgFilterView.clipsToBounds = true
//        bgFilterView.layer.shadowPath = UIBezierPath(rect: bgFilterView.bounds).cgPath

    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgFilterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bgFilterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgFilterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgFilterView.heightAnchor.constraint(equalToConstant: 50),
            
            categoriesView.topAnchor.constraint(equalTo: bgFilterView.bottomAnchor, constant: 16),
            categoriesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesView.heightAnchor.constraint(equalToConstant: categoriesView.getHeight())
            
//            separatorLine.topAnchor.constraint(equalTo: ageFilterCollectionView.bottomAnchor),
//            separatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            separatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            separatorLine.heightAnchor.constraint(equalToConstant: 4)
        ])
        
        ageFilterCollectionView.fullConstraint()
    }
}

extension SuggestionsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgeCell", for: indexPath) as! AgeFilterCell
        let item = items[indexPath.row]
        cell.updateModel(text: item.0)
        cell.makeSelected(bool: item.1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let firstCell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! AgeFilterCell
        firstCell.makeSelected(bool: false)
        let cell = collectionView.cellForItem(at: indexPath) as! AgeFilterCell
        items[indexPath.row].1 = true
        cell.makeSelected(bool: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AgeFilterCell
        items[indexPath.row].1 = false
        cell.makeSelected(bool: false)
    }
    
}

