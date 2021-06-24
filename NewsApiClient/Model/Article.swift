//
//  Article.swift
//  NewsApiClient
//
//  Created by user on 20.06.2021.
//  Copyright © 2021 Artem Ulko. All rights reserved.
//

import Foundation

struct Article: Codable, Equatable {
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?
    var category: NewsCategory?
    
    mutating func setCategory(_ category:NewsCategory) {
        self.category = category
    }
}

struct TopHeadlinesResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
