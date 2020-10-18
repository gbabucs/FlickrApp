//
//  PhotoSearchViewController+UITableView.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation
import UIKit

//--------------------------------------------------------------------------
// MARK: - UITableViewDelegate
//--------------------------------------------------------------------------

extension PhotoSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPhotoCollectionViewController", sender: self.viewModel.searchHistory[indexPath.row])
    }
}

//--------------------------------------------------------------------------
// MARK: - UITableViewDataSource
//--------------------------------------------------------------------------

extension PhotoSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoSearchHistoryTableViewCell.reuseIdentifier) as? PhotoSearchHistoryTableViewCell
            else { return UITableViewCell() }
        
        let searchText = self.viewModel.searchHistory[indexPath.row]
        
        cell.configure(with: searchText)
        
        return cell
    }
}
