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
    
    private let nc = NotificationCenter.default
    private var articles = [Article]()
    private var page: Int = 1
    
    var isLoading: Bool = false
    var pageСategories: [NewsCategory:Int] = {
        var pageСategories: [NewsCategory:Int] = [:]
        NewsCategory.allCases.forEach { pageСategories[$0] = 1 }
        return pageСategories
    }()
    var selectedСategories: [NewsCategory:Bool]! {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(selectedСategories) {
                UserDefaults.standard.set(encoded, forKey: "selectedСategories")
            }
        }
    }
    
    init() {
        if let selectedСategories = UserDefaults.standard.data(forKey: "selectedСategories") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([NewsCategory:Bool].self, from: selectedСategories) {
                self.selectedСategories = decoded
            } else {
                self.selectedСategories = Dictionary(uniqueKeysWithValues: NewsCategory.allCases.map { ($0, $0.isDefault) })
            }
        } else {
            self.selectedСategories = Dictionary(uniqueKeysWithValues: NewsCategory.allCases.map { ($0, $0.isDefault) })
        }
        
        let categories = self.selectedСategories
            .filter { $0.value }
            .keys.map { $0 }
 
        loadNews(categories: categories)
    }
    
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
            guard let page = pageСategories[$0] else { return }
            isLoading = true
            NewsApiService.getTopHeadlines(page: page, category: $0) { [unowned self] (articles, error, category) in
                if let articles = articles {
                    
                    guard
                        let categoryIsSelected = self.selectedСategories[category],
                        categoryIsSelected
                    else { return }

                    self.articles.append(contentsOf: articles)
                    self.articles.sort { $0.publishedAt! > $1.publishedAt! }
                    self.isLoading = false
                    self.nc.post(name: .newsUpdated, object: self)
                }
            }
        }
    }
    
    func loadMoreNews() {
        let categories = self.selectedСategories
            .filter { $0.value }
            .keys.map { $0 }
        
        categories.forEach {
            guard let value = self.pageСategories[$0] else { return }
            self.pageСategories.updateValue(value + 1, forKey: $0)
        }

        loadNews(categories: categories)
    }
    
    func addCategory(_ category:NewsCategory) {
        selectedСategories[category] = true
        loadNews(categories: [category])
    }
    
    func removeCategory(_ category:NewsCategory) {
        selectedСategories[category] = false
        articles = articles .filter { $0.category != category }
        pageСategories.updateValue(1, forKey: category)
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
