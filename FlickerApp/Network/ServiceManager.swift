//
//  ServiceManager.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation
import Alamofire


class ServiceManager {
    
    private let flickrAPI: FlickrAPI
    
    //--------------------------------------------------------------------------
    // MARK: - Typealias
    //--------------------------------------------------------------------------
    
    typealias ResponseHandler<T> = (Result<T, Error>) -> ()
    
    init(flickrAPI: FlickrAPI) {
        self.flickrAPI = flickrAPI
    }
    
    //--------------------------------------------------------------------------
    // MARK: - API Requests
    //--------------------------------------------------------------------------
    
    /// Get Flicker Image request  using  `load`
    ///
    /// - Parameters:
    ///   - completion:    The `ResponseHandler` value
    
    func load<T: Codable>(completion: @escaping ResponseHandler<T>) {
        
        let url = flickrAPI.relativeURL
        let httpMethod = flickrAPI.httpMethod
        
        AF.request(url, method: httpMethod).validate().responseJSON { response in
            ThreadHelper.mainThreadAsync {
                switch response.result {
                case .success:
                    guard let data = response.data else { return completion(.failure(AppError.badResponse)) }
                    guard let result = try? JSONDecoder().decode(T.self, from: data) else { return completion(.failure(AppError.jsonError)) }
                    
                    completion(.success(result))
                case .failure(let error):
                    print("Failed request with given url: \(url)", error)
                    completion(.failure(error))
                }
            }
        }
    }
}
