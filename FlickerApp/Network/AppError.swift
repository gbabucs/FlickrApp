//
//  AppError.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation

public enum AppError: Error {
    case noInternet
    case badResponse
    case jsonError
}

extension AppError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .badResponse:
            return NSLocalizedString("Invalid response.", comment: "badResponse")
        case .jsonError:
            return NSLocalizedString("Unable to decode the json.", comment: "jsonError")
        case .noInternet:
            return NSLocalizedString("Please check your Internet connection.", comment: "No Internet")
        }
    }
}
