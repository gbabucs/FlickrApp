//
//  PhotoSearchViewController+UISearchBar.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation
import UIKit


//--------------------------------------------------------------------------
// MARK: - UISearchBarDelegate
//--------------------------------------------------------------------------

extension PhotoSearchViewController: UISearchBarDelegate {
    
    struct Key {
        static let identifier = "showPhotoCollectionViewController"
    }
    
    //--------------------------------------------------------------------------
    // MARK: - User Interaction
    //--------------------------------------------------------------------------
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        self.viewModel.save(search: searchText, with: updateTableView)
        
        performSegue(withIdentifier: Key.identifier, sender: searchText)
        self.resetSearchBar()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resetSearchBar()
    }
}
