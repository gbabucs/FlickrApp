//
//  PhotoSearchViewModel.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation

class PhotoSearchViewModel {
    
    //--------------------------------------------------------------------------
    // MARK: - Typealias
    //--------------------------------------------------------------------------
    
    typealias completionHandler = () -> ()
    
    //--------------------------------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------------------------------
    
    let defaults = UserDefaults.standard
    var searchHistory: [String] = []
    
    //--------------------------------------------------------------------------
    // MARK: - Struct
    //--------------------------------------------------------------------------
    
    struct Key {
        static let search = "SearchHistoryKey"
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Init
    //--------------------------------------------------------------------------
    
    init(history: [String] = []) {
        self.searchHistory = history
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Functions
    //--------------------------------------------------------------------------
    
    func getSearchHistory(completion: completionHandler) {
        guard let result = defaults.object(forKey: Key.search),
            let data = result as? [String] else { return }
        
        self.searchHistory = data
        
        completion()
    }

    func save(search text: String, with completion: completionHandler) {
        let uniqueSearch = searchHistory.filter { $0.lowercased() != text.lowercased() }
        
        self.searchHistory = uniqueSearch
        self.searchHistory.insert(text, at: 0)
        
        self.defaults.set(searchHistory, forKey: Key.search)
        self.defaults.synchronize()
        
        completion()
    }
    
}

