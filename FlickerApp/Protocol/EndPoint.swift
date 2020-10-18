//
//  EndPoint.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation
import Alamofire

protocol EndPoint {
    var baseURL: String { get }
    var httpMethod: HTTPMethod { get }
    var relativeURL: String { get }
}
