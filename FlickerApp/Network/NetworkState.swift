//
//  NetworkState.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation
import Alamofire

class NetworkState {
    
    class func isConnected() -> Bool {
        guard let reachabilityManager = NetworkReachabilityManager() else { return false }
        
        return reachabilityManager.isReachable
    }
}
