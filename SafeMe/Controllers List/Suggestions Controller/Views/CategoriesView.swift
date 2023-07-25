//
//  CategoriesView.swift
//  SafeMe
//
//  Created by Temur on 25/07/2023.
//

import UIKit

class CategoriesView: UIView {
    private var collectionView: UICollectionView!
    private var items: [CategoryModel] = [
        CategoryModel(image: "internet", title: "Xavfsiz internet", color: "#63D586"),
        CategoryModel(image: "game", title: "Oyinlar", color: "#C7A9F5"),
        CategoryModel(image: "envelope", title: "Fake xabarlar", color: "#FFA607")
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        self.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        
        SetupViews.addViewEndRemoveAutoresizingMask(superView: self, array: [collectionView])
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func getHeight() -> CGFloat {
        if items.count % 2 == 0 {
            return CGFloat(64 * (items.count / 2)) + 10
        }else {
            return CGFloat(64 * ((items.count / 2) + 1)) + 10
        }
    }
}

extension CategoriesView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.updateModel(model: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width:(collectionView.bounds.width)/2, height: 64)
        return size
    }
    
}
