//
//  PhotoRequest.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation

class PhotoRequest: NSObject {
    
    //--------------------------------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------------------------------
    
    private let method: String
    private let searchQuery: String
    private let page: Int
    private let itemsPerPage: Int
    
    struct Key {
        static let currentPage = "currentPage"
        static let totalPages = "totalPages"
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Typealias
    //--------------------------------------------------------------------------
    
    typealias PhotosResultHandler = ([Photo]?, [String: Any]?, Error?) -> ()
    
    //--------------------------------------------------------------------------
    // MARK: - Init
    //--------------------------------------------------------------------------
    
    init(searchQuery: String = "",
         method: String = "",
         page: Int = 0,
         itemsPerPage: Int = 0) {
        self.searchQuery = searchQuery
        self.method = method
        self.page = page
        self.itemsPerPage = itemsPerPage
    }
    
    //--------------------------------------------------------------------------
    // MARK: - API Request
    //--------------------------------------------------------------------------
    
    /// Get search photos using  `requestPhotos`
    /// the provided `destination` using the `searchText`, `page`, `itemsPerPage`
    ///
    /// - Parameters:
    ///   - completion:     The `PhotosResultHandler` value
    
    func requestPhotos(completion: @escaping PhotosResultHandler) {
        
        let parameters = "&text=\(searchQuery)&page=\(page)&per_page=\(itemsPerPage)"
        let dataProvider = DataProvider(parameters: parameters, method: self.method)
        
        dataProvider.fetchFlickImage() { [weak self] result in
            switch result {
            case .success(let response):
                guard let strongSelf = self else { return }
                
                let photos = strongSelf.parsePhotos(with: response)
                let metaData = strongSelf.parseMetaData(with: response)
                
                completion(photos, metaData, nil)
            case .failure(let error):
                completion(nil, nil, error)
            }
        }
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Helpers
    //--------------------------------------------------------------------------
    
    
    func parsePhotos(with value: FlickerImageResult) -> [Photo] {
        return value.photos.photo
    }
    
    func parseMetaData(with value: FlickerImageResult) -> [String: Any] {
        var metaData: [String: Int] = [:]
        
        metaData[Key.currentPage] = value.photos.page
        metaData[Key.totalPages] = value.photos.pages
        
        return metaData
    }
}

