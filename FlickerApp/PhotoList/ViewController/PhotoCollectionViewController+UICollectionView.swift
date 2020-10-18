//
//  PhotoCollectionViewController+UICollectionView.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import UIKit

//--------------------------------------------------------------------------
// MARK: - UICollectionViewDataSource
//--------------------------------------------------------------------------

extension PhotoCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let viewModel = viewModel else { return 0 }

        return viewModel.photos.count / viewModel.itemsPerSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        
        return viewModel.itemsPerSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell,
            let viewModel = viewModel
            else { return UICollectionViewCell() }
        
        let index = indexPath.row + (indexPath.section * viewModel.itemsPerSection)
        let imageURL = viewModel.photos[index].imageURL
        
        cell.configure(with: imageURL)
        
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale

        return cell
    }
}

//--------------------------------------------------------------------------
// MARK: - UICollectionViewDelegateFlowLayout
//--------------------------------------------------------------------------

extension PhotoCollectionViewController: UICollectionViewDelegate {
    
    //--------------------------------------------------------------------------
    // MARK: - Lazy Loading
    //--------------------------------------------------------------------------
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let viewModel = viewModel else { return }
        
        let itemsPerPage = viewModel.itemsPerPage
        let itemsPerSection = viewModel.itemsPerSection
        let itemsLimit = viewModel.itemsLimit
        
        let currentItem = indexPath.row + (indexPath.section * itemsPerSection)
        let limit = (viewModel.currentPage * itemsPerPage) - itemsLimit
        let isLoadMore = (currentItem > limit) && (viewModel.currentPage < viewModel.totalPages)
        
        
        if NetworkState.isConnected() {
            if isLoadMore {
                viewModel.requestPhotos { error in
                    ThreadHelper.mainThreadAsync {
                        if let error = error  {
                            self.showAlert(with: "Flickr App", error: error.localizedDescription)
                        }
                        self.updateCollectionView()
                    }
                }
            }
        } else {
            let networkError = AppError.noInternet
            
            self.showAlert(with: "Flickr App", error: networkError.localizedDescription)
        }
    }
}

