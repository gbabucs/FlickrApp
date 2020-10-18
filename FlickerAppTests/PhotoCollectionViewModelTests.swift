//
//  PhotoCollectionViewModelTests.swift
//  FlickerAppTests
//
//  Created by Babu on 18/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import XCTest

class PhotoCollectionViewModelTests: XCTestCase {
    
    var viewModel: PhotoCollectionViewModel!
    
    override func setUp() {
        super.setUp()
        self.viewModel = PhotoCollectionViewModel(searchText: "kittens")
    }
    
    override func tearDown() {
        self.viewModel = nil
        super.tearDown()
    }
    
    func testViewModelPhotosIsEmpty() {
        let photos = valuesFromJSON(name: "InvalidText")
        
        self.viewModel.photos = photos
        
        XCTAssertNotEqual(self.viewModel.photos.count, 100, "Expected both viewModel and model have different values")
        
        XCTAssertEqual(self.viewModel.photos.count, 0, "Expected both viewModel and model have 0 values")
    }
    
    func testViewModelPhotosIsNotEmpty() {
        let photos = valuesFromJSON(name: "FlickrResult")
        
        self.viewModel.photos = photos
        
        XCTAssertEqual(self.viewModel.photos.count, 100, "Expected both viewModel and model have same data")
    }
    
    
    func valuesFromJSON(name: String) -> [Photo] {
        var responsePhoto = [Photo]()
        
        guard let data = FileManager.readJsonFile(forResource: name)
            else {
                XCTAssertFalse(false, "Can't get data from FlickrResult.json")
                return responsePhoto
        }
        
        let dataProvider = DataProvider(parameters: "", method: "")
        
        guard let flickImageResult = dataProvider.processData(type: FlickerImageResult.self, response: data)
            else {
                XCTAssertFalse(false, "Can't parse json")
                return responsePhoto
        }
        
        responsePhoto = flickImageResult.photos.photo
        
        return responsePhoto
    }
}

extension FileManager {
    static func readJsonFile(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: PhotoCollectionViewModelTests.self)
        
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                return data
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
