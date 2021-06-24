//
//  News.swift
//  NewsApiClient
//
//  Created by user on 18.06.2021.
//  Copyright © 2021 Artem Ulko. All rights reserved.
//

import Foundation
import UIKit

enum NewsCategory: Int, Codable, CaseIterable {
    case general
    case business
    case entertainment
    case health
    case science
    case sports
    case technology
}

extension NewsCategory {
    var isDefault: Bool {
        switch self {
        
        case .general:
            return true
        case _:
            return false
        }
    }
    
    var stringValue: String {
        switch self {
        
        case .business:
            return "business"
        case .entertainment:
            return "entertainment"
        case .general:
            return "general"
        case .health:
            return "health"
        case .science:
            return "science"
        case .sports:
            return "sports"
        case .technology:
            return "technology"
        }
    }
    
    var titleValue: String {
        switch self {
        
        case .business:
            return "Бизнес"
        case .entertainment:
            return "Досуг"
        case .general:
            return "Главное"
        case .health:
            return "Здоровье"
        case .science:
            return "Наука"
        case .sports:
            return "Спорт"
        case .technology:
            return "Технологии"
        }
    }
    
    var image: UIImage? {
        switch self {
        
        case .business:
            return UIImage(named: self.stringValue)
        case .entertainment:
            return UIImage(named: self.stringValue)
        case .general:
            return UIImage(named: self.stringValue)
        case .health:
            return UIImage(named: self.stringValue)
        case .science:
            return UIImage(named: self.stringValue)
        case .sports:
            return UIImage(named: self.stringValue)
        case .technology:
            return UIImage(named: self.stringValue)
        }
    }
    
    var emojiValue: String {
        switch self {
        
        case .general:
            return "🚩"
        case .business:
            return "👔"
        case .entertainment:
            return  "🎪"
        case .health:
            return  "🏥"
        case .science:
            return  "👨‍🔬"
        case .sports:
            return  "🏈"
        case .technology:
            return  "🖥"
        }
    }
}
