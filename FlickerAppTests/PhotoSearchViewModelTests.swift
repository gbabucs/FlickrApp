//
//  PhotoSearchViewModelTests.swift
//  FlickerAppTests
//
//  Created by Babu on 18/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import XCTest

class PhotoSearchViewModelTests: XCTestCase {
    
    var viewModel: PhotoSearchViewModel!
    
    override func setUp() {
        viewModel = PhotoSearchViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testSearchTextInUserDefaults_saving_values() {
        let searchText = "Amsterdam"
        let differentText = "Paris"
        
        self.viewModel.save(search: searchText) {
            XCTAssertEqual(viewModel.searchHistory.contains(searchText), true, "Expected searchHistroy contains Amsterda")
            XCTAssertEqual(viewModel.searchHistory.contains(differentText), false, "Expected searchHistroy doesn't contains some other Value")
        }
    }
    
    func testGetSearchHistoryInUserDefaults_contains_values() {
        let searchText1 = "Amsterdam"
        let searchText2 = "Netherlands"
        
        self.viewModel.save(search: searchText1) { }
        self.viewModel.save(search: searchText2) { }
        
        self.viewModel.getSearchHistory {
            XCTAssertEqual(viewModel.searchHistory.contains(searchText1), true, "Expected searchHistroy contains Amsterdam")
            XCTAssertEqual(viewModel.searchHistory.contains(searchText2), true, "Expected searchHistroy contains Netherlands")
        }
    }
    
}
