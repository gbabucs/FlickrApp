//
//  FlickrAPITests.swift
//  FlickerAppTests
//
//  Created by Babu on 18/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import XCTest
import Alamofire

class FlickrAPITests: XCTestCase {

    func testFlickrAPI_values() {
        let parameter = "paris"
        let method = "flickr.photos.search"
        let baseURL = "https://api.flickr.com/services/rest/"
        let apiKey = "somedifferentKey"
        let httpMethod = HTTPMethod.get
        let formatString = "&format=json&nojsoncallback=1"
        let relativeURL = baseURL + "?method=\(method)\(formatString)\(parameter)&api_key=\(apiKey)"
        
        let userSearch = FlickrAPI.userSearch(query: parameter, method: method)
        
        XCTAssertEqual(userSearch.baseURL, baseURL, "Expected both have same \(baseURL)")
        XCTAssertEqual(userSearch.format, formatString, "Expected both have same \(formatString)")
        XCTAssertEqual(userSearch.httpMethod, httpMethod, "Expected both have same \(httpMethod)")
        XCTAssertNotEqual(userSearch.apiKey, apiKey, "Expected both have different apikeys")
        XCTAssertNotEqual(userSearch.relativeURL, relativeURL, "Expected both have different because apikey is different \(relativeURL)")
        
    }
}
