//
//  PhotoSearchViewControllerTests.swift
//  FlickerAppTests
//
//  Created by Babu on 18/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import XCTest
@testable import FlickerApp

class PhotoSearchViewControllerTests: XCTestCase {

    var sut: PhotoSearchViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
        
        sut = navigationController?.topViewController as? PhotoSearchViewController
        
        _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_sut_Can_Instantiate_SearchViewController() {
        XCTAssertNotNil(sut)
    }
    
    func test_sut_TableView_Is_NotNil_After_ViewDidLoad() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_sut_Has_Values_For_TableView() {
        XCTAssertNotNil(sut.viewModel.searchHistory)
    }
    
    func test_sut_ShouldSet_TableViewDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func test_TableView_Has_Delegate() {
        XCTAssertNotNil(sut.tableView.delegate)
    }
    
    func test_TableView_Confroms_TableViewDelegateProtocol() {
        XCTAssertTrue(sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:didSelectRowAt:))))
    }
    
    func test_sut_TableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
    }
    
    // MARK: - Storyboard Segues

    // utility for finding segues
    func hasSegueWithIdentifier(id: String) -> Bool {
    
        let segues = sut.value(forKey: "storyboardSegueTemplates") as? [NSObject]
        let filtered = segues?.filter({ $0.value(forKey: "identifier") as? String == id })
        
        return (filtered?.count ?? 0) > 0
    }
    
    func test_sut_HasSegue_Name_showPhotoCollectionViewController() {

        let targetIdentifier = "showPhotoCollectionViewController"
        XCTAssertTrue(hasSegueWithIdentifier(id: targetIdentifier))
    }
    
    func test_Alert_Not_Show() {
        sut.showAlert(with: "Title", error: "error")
        
        XCTAssertFalse(sut.presentingViewController is UIAlertController)
    }
}

