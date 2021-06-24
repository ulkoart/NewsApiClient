//
//  NewsCategoryCell.swift
//  NewsApiClient
//
//  Created by user on 18.06.2021.
//  Copyright © 2021 Artem Ulko. All rights reserved.
//

import UIKit

class NewsCategoryCell: UICollectionViewCell {
    static let Identifier: String = "NewsCategoryCell"
    
    var categoryType: NewsCategory!
    var isSelectedCategory: Bool = false {
        willSet {
            categoryImage.layer.opacity = newValue ? 1:0.4
        }
    }
    var categoryViewCellDelegate: CategoryViewCellDelegate!
    
    let categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.opacity = 0.3
        return imageView
    }()
    
    let categoryTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "DINAlternate-Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 2, height: 2)

        addSubview(categoryImage)
        addSubview(categoryTitle)
        
        // MARK: - categoryImage constraints
        categoryImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        categoryImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        categoryImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        categoryImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        // MARK: - categoryTitle constraints
        categoryTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6).isActive = true
        categoryTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        categoryTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
