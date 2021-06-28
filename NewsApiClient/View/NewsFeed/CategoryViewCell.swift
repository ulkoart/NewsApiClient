//
//  CategoryViewCell.swift
//  NewsApiClient
//
//  Created by user on 20.06.2021.
//  Copyright © 2021 Artem Ulko. All rights reserved.
//

import UIKit

final class CategoryViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "CategoryViewCell"
    var changingCategoriesDelegat: ChangingCategoriesDelegat?
    
    private var selectedСategories: [NewsCategory:Bool]!
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(NewsCategoryCell.self, forCellWithReuseIdentifier: NewsCategoryCell.Identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        contentView.addSubview(collectionView)
        
        collectionView.backgroundColor = .clear
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(selectedСategories: [NewsCategory:Bool]) {
        self.selectedСategories = selectedСategories
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout UICollectionViewDataSource, UICollectionViewDelegate

extension CategoryViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height * 0.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewsCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCategoryCell.Identifier, for: indexPath) as? NewsCategoryCell
            else { fatalError() }
        
        guard
            let category: NewsCategory = NewsCategory.init(rawValue: indexPath.item),
            let categoryImage: UIImage = category.image,
            let isSelectedCategory = self.selectedСategories[category]
            else { fatalError() }
        
        cell.categoryImage.image = categoryImage
        cell.categoryTitle.text = category.titleValue
        cell.categoryType = category
        cell.isSelectedCategory = isSelectedCategory
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let currentCell = collectionView.cellForItem(at: indexPath) as? NewsCategoryCell
            else { fatalError() }
        
        // Changing categories
        
        currentCell.isSelectedCategory = !currentCell.isSelectedCategory
        self.selectedСategories[currentCell.categoryType] = currentCell.isSelectedCategory
        self.changingCategoriesDelegat?.categoryHasChanged(category: currentCell.categoryType, select: currentCell.isSelectedCategory)
    }
}

