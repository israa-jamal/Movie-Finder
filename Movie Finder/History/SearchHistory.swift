//
//  SearchHistory.swift
//  Movie Finder
//
//  Created by Esraa Gamal on 10/22/20.
//  Copyright © 2020 Esraa Gamal. All rights reserved.
//

import Foundation

class SearchHistory {
  
    static var history : [String] = []
    let defaults = UserDefaults.standard
    
     func addNewElementToSearchHistory(add element: String) {
        if let index = SearchHistory.history.firstIndex(of: element){
                       SearchHistory.history.remove(at: index)
        }
        if SearchHistory.history.count == 10 {
            SearchHistory.history.remove(at: 9)
        }

        SearchHistory.history.insert(element, at: 0)
        defaults.set(SearchHistory.history, forKey: "history")
    }
    func getHistoryElementsCount() -> Int{
        return SearchHistory.history.count
    }
    func getSearchHistoryElements(indexPath: IndexPath) -> String?{
//        if let historyArray = SearchHistory.searchHistory[indexPath.row]{
//            return historyArray
//        }
//        return nil
        return SearchHistory.history[indexPath.row]
    }
    func getAllHistory()-> [String]{
        return SearchHistory.history
    }
}


