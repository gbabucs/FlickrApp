//
//  PhotoSearchViewController.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import UIKit

class PhotoSearchViewController: UIViewController {
    
    //--------------------------------------------------------------------------
    // MARK: - IBOutlets
    //--------------------------------------------------------------------------
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchHistory: UILabel!
    
    //--------------------------------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------------------------------
    
    let viewModel = PhotoSearchViewModel()
    
    //--------------------------------------------------------------------------
    // MARK: - ViewController Lifecycle
    //--------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Flickr Search"
        self.viewModel.getSearchHistory(completion: updateTableView)
        self.setupTableView()
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Helpers
    //--------------------------------------------------------------------------
    
    func setupTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 74.0
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func resetSearchBar() {
        self.searchBar.resignFirstResponder()
        self.searchBar.text = ""
    }
    
    func updateTableView() {
        self.tableView.reloadData()
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Navigation
    //--------------------------------------------------------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let photoCollectionViewController = segue.destination as? PhotoCollectionViewController
            else { return }
        
        let searchText = sender as? String ?? ""
        let viewModel = PhotoCollectionViewModel(searchText: searchText)
        
        photoCollectionViewController.viewModel = viewModel
    }
}
