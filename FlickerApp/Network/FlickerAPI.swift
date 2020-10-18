//
//  FlickerAPI.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation
import Alamofire

struct FlickrAPIConstant {
    static let apiKey = "6af377dc54798281790fc638f6e4da5e"
}

enum FlickrAPI {
    case userSearch(query: String, method: String)
}

//--------------------------------------------------------------------------
// MARK: - EndPoint
//--------------------------------------------------------------------------

extension FlickrAPI: EndPoint {

    var baseURL: String {
        return "https://api.flickr.com/services/rest/"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var format: String {
        return "&format=json&nojsoncallback=1"
    }
    
    var apiKey: String {
        return FlickrAPIConstant.apiKey
    }
    
    var relativeURL: String {
        switch self {
        case .userSearch(let parameters, let method):
            return baseURL + "?method=\(method)\(format)\(parameters)&api_key=\(apiKey)"
        }
    }
}

