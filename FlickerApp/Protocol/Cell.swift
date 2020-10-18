//
//  Cell.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation

protocol Cell: class {
    
    static var reuseIdentifier: String { get }
    
    associatedtype T
    
    func configure(with value: T)
}

extension Cell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func configure(with value: T) {}
}
