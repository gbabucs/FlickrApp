//
//  NetworkStateTests.swift
//  FlickerAppTests
//
//  Created by Babu on 18/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import XCTest

class NetworkStateTests: XCTestCase {

    func testNetworkStateReachable() {
        let isReachable = NetworkState.isConnected()
        
        if isReachable {
            XCTAssertTrue(isReachable, "Internet Connection Available!")
        } else {
            XCTAssertFalse(isReachable, "Internet Connection not Available!")
        }
    }

}
