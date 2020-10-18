//
//  PhotoCollectionViewController.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import UIKit
import JGProgressHUD

class PhotoCollectionViewController: UIViewController {
    
    //--------------------------------------------------------------------------
    // MARK: - IBOutlets
    //--------------------------------------------------------------------------
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //--------------------------------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------------------------------
    
    var viewModel: PhotoCollectionViewModel?
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    let progress = JGProgressHUD(style: .dark)
    
    //--------------------------------------------------------------------------
    // MARK: - ViewController LifeCycle
    //--------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progress.textLabel.text = "Loading"
        self.setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if NetworkState.isConnected() {
            self.progress.show(in: self.view)
            self.viewModel?.requestPhotos { error in
                
                ThreadHelper.mainThreadAsync {
                    if let error = error  {
                        self.showAlert(with: "Flickr App", error: error.localizedDescription)
                    }
                    self.updateCollectionView()
                    self.progress.dismiss()
                }
            }
            
        } else {
            let networkError = AppError.noInternet
            
            self.showAlert(with: "Flickr App", error: networkError.localizedDescription)
        }
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Helpers
    //--------------------------------------------------------------------------
    
    private func setupNavigationBar() {
        self.navigationItem.title = viewModel?.navigationTitle
    }
    
    func updateCollectionView() {
            if self.collectionView.numberOfSections == 0 {
                self.collectionView.reloadData()
            } else {
                let numberOfSections = self.collectionView.numberOfSections
                let lastIndexOfNewSections = numberOfSections + 2
                
                if lastIndexOfNewSections > numberOfSections {
                    let indexSet = IndexSet(integersIn: numberOfSections...lastIndexOfNewSections)
                    self.collectionView.insertSections(indexSet)
                }
            }
    }
    
}
