//
//  RecommendationsView.swift
//  SafeMe
//
//  Created by Temur on 29/07/2023.
//

import UIKit

class RecommendationsView: UIView {
    private var collectionView: UICollectionView!
    private var items: [Recommendation] = []
    var selectAction: ((Recommendation) -> ())?
    
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
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RecommendationCell.self, forCellWithReuseIdentifier: "RecommendationCell")
        
        

        
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
            return CGFloat(224 * (items.count / 2)) + 10
        }else {
            return CGFloat(224 * ((items.count / 2) + 1)) + 10
        }
    }
    
    func updateItems(_ items: [Recommendation]) {
        self.items = items
        self.collectionView.reloadData()
    }
}

extension RecommendationsView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCell", for: indexPath) as! RecommendationCell
        cell.updateModel(model: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width:(collectionView.bounds.width)/2, height: self.bounds.width * 0.33)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectAction?(items[indexPath.row])
    }
    
}
