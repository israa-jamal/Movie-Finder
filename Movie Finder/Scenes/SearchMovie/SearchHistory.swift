//
//  SearchHistory.swift
//  Movie Finder
//
//  Created by Esraa Gamal on 10/22/20.
//  Copyright © 2020 Esraa Gamal. All rights reserved.
//

import Foundation

class SearchHistory: SearchHistoryDelegate {
    static var searchHistory : [String]?
    func addNewElementToSearchHistory(add element: String) {
        SearchHistory.searchHistory?.append(element)
    }
    func getHistoryElementsCount() -> Int{
        if let historyArray = SearchHistory.searchHistory{
            print(historyArray)
        return historyArray.count
        }
        return 0
    }
    func getSearchHistoryElements(indexPath: IndexPath) -> String?{
        if let historyArray = SearchHistory.searchHistory{
            return historyArray[indexPath.row]
        }
        return nil
    }
}


