//
//  NewsFeedTableViewCell.swift
//  NewsApiClient
//
//  Created by user on 17/06/2021.
//  Copyright © 2021 Artem Ulko. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "NewsFeedTableViewCell"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    
    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    weak var viewModel: NewsFeedCellViewModel! {
        willSet(viewModel) {
            titleLabel.text = viewModel.title
            dateLabel.text = viewModel.publishedAt
            
            if let category = viewModel.category {
                categoryLabel.text = category.emojiValue
            }
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // MARK: - titleLabel
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4).isActive = true
        
        // MARK: - dateLabel
        contentView.addSubview(dateLabel)
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        
        // MARK: - categoryLabel
        contentView.addSubview(categoryLabel)
        categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        contentView.layer.cornerRadius = 12
    }
}
