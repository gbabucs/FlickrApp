//
//  PhotoRequestTests.swift
//  FlickerAppTests
//
//  Created by Babu on 18/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import XCTest

class PhotoRequestTests: XCTestCase {
    
    var photoRequest: PhotoRequest!
    
    override func setUp() {
        self.photoRequest = PhotoRequest()
    }
    
    override func tearDown() {
        self.photoRequest = nil
    }
    
    func test_Parse_Photo_have_original_model_values() {
        let photos = self.photoRequest.parsePhotos(with: imageResult)
        
        XCTAssertEqual(photos.count, imageResult.photos.photo.count, "Expected both should have same count")
        XCTAssertEqual(photos.first?.imageURL, imageResult.photos.photo.first?.imageURL, "Expected both should have same imageURL: \(String(describing: photos.first?.imageURL))")
        XCTAssertEqual(photos.first?.id, imageResult.photos.photo.first?.id, "Expected both should have same id: \(String(describing: photos.first?.id))")
    }
    
    func test_Parse_MetaDataContains_CurrentPage_and_totalPages() {
        let metaData = self.photoRequest.parseMetaData(with: imageResult)
        let currentPage = metaData["currentPage"] as? Int
        let totalPages = metaData["totalPages"] as? Int
        
        XCTAssertEqual(currentPage, imageResult.photos.page, "Expected both should have same page count")
        XCTAssertEqual(totalPages, imageResult.photos.pages, "Expected both should have same pages count")
    }
    
    func test_request_Photos() {        
        let photoRequest = PhotoRequest(searchQuery: "Paris", method: "flickr.photos.search", page: 1, itemsPerPage: 30)
        let expectation = self.expectation(description: "Wait for url to load.")
        var photos: [Photo]?
        
        photoRequest.requestPhotos() { photosResponse, metaData, error in
            photos = photosResponse
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(photos)
    }
    
    func test_request_Photos_ReturnError() {
        let photoRequest = PhotoRequest(searchQuery: "Paris", method: "", page: 1, itemsPerPage: 30)
        let expectation = self.expectation(description: "Wait for url to load.")
        var appError: AppError?
        
        photoRequest.requestPhotos() { photos, metaData, error in
            XCTAssertEqual(photos?.count, nil)
            appError = error as? AppError
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        let expectedError  = AppError.jsonError
        XCTAssertEqual(appError, expectedError)
    }
    
}


private let photo = Photo(id: "1", owner: "135162570", secret: "2bbb5d92b0", server: "65535", farm: 66, title: "Casper", ispublic: 1, isfriend: 0, isfamily: 0)
private let photos = Photos(page: 1, pages: 1707, perpage: 100, total: "170636", photo: [photo])
private let imageResult = FlickerImageResult(photos: photos, stat: "ok")
