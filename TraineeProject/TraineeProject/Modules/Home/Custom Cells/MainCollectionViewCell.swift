//
//  MainCollectionViewCell.swift
//  TraineeProject
//
//  Created by TTN on 30/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
        @IBOutlet weak var moviePosterImage: UIImageView!
        @IBOutlet weak var labelContainer: UIView!
        @IBOutlet weak var movieNameLabel: UILabel!
        @IBOutlet weak var secondaryLabel: UILabel!
        
        static let identifier = "MainCollectionViewCell"
        
        static func nib() -> UINib {
            return UINib(nibName: "MainCollectionViewCell", bundle: nil)
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            moviePosterImage.layer.cornerRadius = 10
        }
        
        func configure(_ data: MovieInfo?){
            if let url = URL(string: "https://image.tmdb.org/t/p/w500" + (data?.poster_path ?? "" )){
            moviePosterImage.downloadedFrom(url: url)
            }
            movieNameLabel.text = data?.title
            secondaryLabel.text = data?.release_date
        }
    }
