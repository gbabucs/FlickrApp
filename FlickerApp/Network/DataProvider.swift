
//
//  DataProvider.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation

class DataProvider {
    
    //--------------------------------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------------------------------
    
    private let parameters: String
    private let method: String
    
    //--------------------------------------------------------------------------
    // MARK: - Typealias
    //--------------------------------------------------------------------------
    
    typealias CompletionHandler<T> = (Result<T, Error>) -> ()
    
    //--------------------------------------------------------------------------
    // MARK: - Init
    //--------------------------------------------------------------------------
    
    init(parameters: String,
         method: String) {
        self.parameters = parameters
        self.method = method
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Functions
    //--------------------------------------------------------------------------
    
    /// Get Flicker Image response using  `fetchFlickImage`
    ///
    /// - Parameters:
    ///   - completion:    The `GetCompletionHandler` value
    
    func fetchFlickImage(completion: @escaping CompletionHandler<FlickerImageResult>) {
        let service = ServiceManager(flickrAPI: .userSearch(query: parameters, method: method))
        
       service.load { (_ result: Result<FlickerImageResult, Error>) in
           switch result {
           case .success(let news):
               completion(.success(news))
           case .failure(let error):
               completion(.failure(error))
           }
       }
    }
}


extension DataProvider {
    
    func processData<T: Codable>(type: T.Type, response: Data?) -> T? {
        var result: T? = nil
        
        if let jsondata = response {
            do {
                let object = try JSONDecoder().decode(T.self, from: jsondata)
                
                result = object
                
            } catch let jsonError {
                print("Error decoding Json Questons", jsonError)
            }
        }
        
        return result
    }
}
