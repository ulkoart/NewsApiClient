//
//  NewsApiService.swift
//  NewsApiClient
//
//  Created by user on 20.06.2021.
//  Copyright © 2021 Artem Ulko. All rights reserved.
//

import Foundation

final class NewsApiService {
    
    private enum Endpoints {
        private static let baseURL = "https://newsapi.org/v2/"
        private static let apiKey = "928161ee44754218bf713fd797f17ea7"
        private static let pageSize = 10
        
        case topHeadlines(Int, NewsCategory)
        
        var stringValue: String {
            switch self {
            case .topHeadlines(let page, let category):
                return Endpoints.baseURL + "top-headlines?country=ru&pageSize=\(Endpoints.pageSize)&category=\(category.stringValue)&page=\(page)&apiKey=" + Endpoints.apiKey
            }
        }
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
    }
    
    static func getTopHeadlines(page: Int, category: NewsCategory, completionHandler: @escaping ([Article]?, Error?) -> Void) {
        
        var request = URLRequest(url: self.Endpoints.topHeadlines(page, category).url)
        request.timeoutInterval = 5
        
        print(self.Endpoints.topHeadlines(page, category).url.absoluteURL)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let topHeadlinesResponse = try decoder.decode(TopHeadlinesResponse.self, from: data)
                var articles = topHeadlinesResponse.articles
                
                // Set category, because there is no such information in API, but it is known to which category the request is
                
                for index in (0..<articles.count) {
                    articles[index].category = category
                }
                
                completionHandler(articles, nil)
            } catch let error {
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}
