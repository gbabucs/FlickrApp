//
//  PhotoCollectionViewCell.swift
//  FlickerApp
//
//  Created by Babu on 16/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    //--------------------------------------------------------------------------
    // MARK: - IBOutlets
    //--------------------------------------------------------------------------
    
    @IBOutlet weak var imageView: UIImageView!
    
    //--------------------------------------------------------------------------
    // MARK: - View Methods
    //--------------------------------------------------------------------------
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}

//--------------------------------------------------------------------------
// MARK: - Cell
//--------------------------------------------------------------------------

extension PhotoCollectionViewCell: Cell {
    
    typealias T = String
    
    func configure(with imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        
        let placeholderImage = UIImage(named: "placeholder")
        
        imageView.af.setImage(
            withURL: url,
            placeholderImage: placeholderImage
        )
    }
}



