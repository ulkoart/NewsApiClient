//
//  NewsFeedViewModel.swift
//  NewsApiClient
//
//  Created by user on 20.06.2021.
//  Copyright © 2021 Artem Ulko. All rights reserved.
//

import Foundation
import UIKit

extension Notification.Name {
    static let newsUpdated = Notification.Name("newsUpdated")
}

enum TypesOfNewsFeedSections: Int {
    case newsCategory
    case newsFeed
}

final class NewsFeedViewModel {
    
    init() {
        loadNews(categories: [.general])
    }
    
    let nc = NotificationCenter.default
    
    private var selectedIndexPath: IndexPath?
    private var articles = [Article]()
    private var page: Int = 1
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        guard
            let typesOfNewsFeedSections: TypesOfNewsFeedSections = TypesOfNewsFeedSections.init(rawValue: section)
        else { fatalError() }
        
        switch typesOfNewsFeedSections {
        case .newsCategory:
            return 1
        case .newsFeed:
            return self.articles.count
        }
    }
    
    func getNumberOfSections() -> Int {
        return 2
    }
    
    func getHeightForRowAt(section: Int, viewFrameHeight: CGFloat) -> CGFloat {
        
        guard
            let typesOfNewsFeedSections: TypesOfNewsFeedSections = TypesOfNewsFeedSections.init(rawValue: section)
        else { fatalError() }
        
        switch typesOfNewsFeedSections {
        case .newsCategory:
            return viewFrameHeight / 4
        case .newsFeed:
            return viewFrameHeight / 8
        }
    }
    
    func loadNews(categories: [NewsCategory]) {
        
        categories.forEach {
            NewsApiService.getTopHeadlines(page: self.page, category: $0) { [unowned self] (articles, error) in
                if let articles = articles {
                    self.articles.append(contentsOf: articles)
                    self.articles.sort { $0.publishedAt! > $1.publishedAt! }
                    self.nc.post(name: .newsUpdated, object: self)
                }
            }
        }
    }
    
    func loadMoreNews() {
        // self.page+=1
        // loadNews()
    }
    
    func addCategory(_ category:NewsCategory) {
        loadNews(categories: [category])
    }
    
    func removeCategory(_ category:NewsCategory) {
        articles = articles .filter { $0.category != category }
        self.nc.post(name: .newsUpdated, object: self)
    }
    
    func isNewsLast(_ index: Int) -> Bool {
        if !articles.isEmpty && articles.count - 1 == index {
            return true
        }
        return false
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsFeedCellViewModel {
        let article: Article = articles[indexPath.row]
        return NewsFeedCellViewModel(article: article)
    }
}
