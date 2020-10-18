//
//  PhotoCollectionViewModel.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation

class PhotoCollectionViewModel {
    
    //--------------------------------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------------------------------
    
    let itemsPerPage = 30
    let itemsPerRow = 2
    let itemsLimit = 15
    let itemsPerSection = 10
    
    let searchText: String
    let navigationTitle: String
    
    var photoRequest: PhotoRequest
    var photos: [Photo] = []
    var currentPage = 0
    var totalPages = 0
    
    //--------------------------------------------------------------------------
    // MARK: - Struct
    //--------------------------------------------------------------------------
    
    struct Key {
        static let method = "flickr.photos.search"
        static let currentPage = "currentPage"
        static let totalPages = "totalPages"
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Lifecycle
    //--------------------------------------------------------------------------
    
    init(searchText: String) {
        self.navigationTitle = searchText
        self.searchText = searchText
        self.photoRequest = PhotoRequest()
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Data Interaction
    //--------------------------------------------------------------------------
    
    func requestPhotos(completion: @escaping (_ error: Error?) -> ()) {
        self.currentPage += 1
        
        let searchQuery = searchText.replacingOccurrences(of: " ", with: "+")
        self.photoRequest = PhotoRequest(searchQuery: searchQuery,
                                         method: Key.method,
                                        page: currentPage,
                                        itemsPerPage: itemsPerPage)
        
        photoRequest.requestPhotos() { photos, metaData, error in
            
            guard let photos = photos,
                let currentPage = metaData?[Key.currentPage] as? Int,
                let totalPages = metaData?[Key.totalPages] as? Int
                else { return completion(error) }
            
            self.photos.append(contentsOf: photos)
            
            self.currentPage = currentPage
            self.totalPages = totalPages
            
            completion(nil)
        }
    }
}
