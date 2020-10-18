//
//  PhotoCollectionViewControllerTests.swift
//  FlickerAppTests
//
//  Created by Babu on 18/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import XCTest
@testable import FlickerApp

class PhotoCollectionViewControllerTests: XCTestCase {
    
    var sut1: PhotoSearchViewController!
    var sut2: PhotoCollectionViewController!
    var navigationController: UINavigationController!
    
    override func setUp() {
        
        super.setUp()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
        sut1 = navigationController?.topViewController as? PhotoSearchViewController
        
        _ = sut1.view
        
        try? testSearchBar_WhenTapped_PhotoCollectionViewController()
    }
    
    override func tearDown() {
        sut1 = nil
        navigationController = nil
        super.tearDown()
    }
    
    func testSearchBar_WhenTapped_PhotoCollectionViewController() throws {
        
        let searchBar = UISearchBar()
        searchBar.text = "Amsterdam"
        
        sut1.searchBarSearchButtonClicked(searchBar)
        RunLoop.current.run(until: Date())
        
        sut2 = navigationController.topViewController as? PhotoCollectionViewController
        
        _ = sut2.view
    }
    
    func test_sut_Can_Instantiate_CollectionViewController() {
        XCTAssertNotNil(sut2)
    }
    
    func test_sut_CollectionView_Is_NotNil_After_ViewDidLoad() {
        XCTAssertNotNil(sut2.collectionView)
    }
    
    func test_sut_Has_Values_For_CollectionView() {
        XCTAssertNotNil(sut2.viewModel?.photos)
    }
    
    func test_sut_ShouldSet_CollectionViewDataSource() {
        XCTAssertNotNil(sut2.collectionView.dataSource)
    }
    
    func test_CollectionView_Has_Delegate() {
        XCTAssertNotNil(sut2.collectionView.delegate)
    }
    
    func test_CollectionView_Confroms_UICollectionViewDataSource() {
        XCTAssertTrue(sut2.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(sut2.responds(to: #selector(sut2.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(sut2.responds(to: #selector(sut2.collectionView(_:cellForItemAt:))))
    }

    func test_sut_CollectionView_ConformsTo_UICollectionViewDelegate() {
        XCTAssertTrue(sut2.conforms(to: UICollectionViewDelegate.self))
        XCTAssertTrue(sut2.responds(to: #selector(sut2.collectionView(_:willDisplay:forItemAt:))))
    }
    
    func testSUT_ConformsToCollectionViewDelegateFlowLayout () {
        XCTAssert(sut2.conforms(to: UICollectionViewDelegateFlowLayout.self))
        XCTAssertTrue(sut2.responds(to: #selector(sut2.collectionView(_:layout:sizeForItemAt:))))
        XCTAssertTrue(sut2.responds(to: #selector(sut2.collectionView(_:layout:insetForSectionAt:))))
    }
}
