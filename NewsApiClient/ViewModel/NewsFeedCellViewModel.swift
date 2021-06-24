//
//  NewsFeedCellViewModel.swift
//  NewsApiClient
//
//  Created by user on 21/06/2021.
//  Copyright © 2021 Artem Ulko. All rights reserved.
//

import Foundation

protocol CategoryViewCellDelegate {
    func didSelectCategory(withType: NewsCategory)
}

final class NewsFeedCellViewModel {
    private let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var title: String {
        return self.article.title
    }
    
    var category: NewsCategory? {
        return self.article.category
    }
    
    var publishedAt: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, d.MM.y"
        return formatter.string(from: self.article.publishedAt ?? Date())
    }
}
