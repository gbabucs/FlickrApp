//
//  PhotoSearchHistoryTableViewCell.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import UIKit

class PhotoSearchHistoryTableViewCell: UITableViewCell {
    
    //--------------------------------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------------------------------
    
    @IBOutlet weak var searchHistory: UILabel!
    
    //--------------------------------------------------------------------------
    // MARK: - View Methods
    //--------------------------------------------------------------------------
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.searchHistory.text = ""
    }
}

//--------------------------------------------------------------------------
// MARK: - Cell
//--------------------------------------------------------------------------

extension PhotoSearchHistoryTableViewCell: Cell {
    
    typealias T = String
    
    func configure(with value: String) {
        self.searchHistory.text = value
    }
}
