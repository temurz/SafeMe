//
//  AgeCategoriesView.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import UIKit

class AgeCategoriesView: UIView {
    private var collectionView: UICollectionView!
    private var items = [AgeCategory]()
    private var firstIsSelected = true
    
    var selectAction: ((AgeCategory) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        let ageFilterLayout = UICollectionViewFlowLayout()
        ageFilterLayout.itemSize = CGSize(width: 120, height: 50)
        ageFilterLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: ageFilterLayout)
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(AgeFilterCell.self, forCellWithReuseIdentifier: "AgeCell")
        
        SetupViews.addViewEndRemoveAutoresizingMask(superView: self, view: collectionView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.fullConstraint()
    }
    
    func updateItems(items: [AgeCategory]) {
        self.items = items
        collectionView.reloadData()
    }
}


extension AgeCategoriesView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgeCell", for: indexPath) as! AgeFilterCell
        let item = items[indexPath.row]
        cell.updateModel(model: item)
        cell.makeSelected(bool: indexPath.row == 0 && firstIsSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        firstIsSelected = indexPath.row == 0 ? true : false
        if let firstCell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? AgeFilterCell {
            firstCell.makeSelected(bool: false)
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! AgeFilterCell
        cell.makeSelected(bool: true)
        
        self.selectAction?(items[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AgeFilterCell
        cell.makeSelected(bool: false)
    }
}
