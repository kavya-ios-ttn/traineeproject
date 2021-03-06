//
//  TableViewCell.swift
//  TraineeProject
//
//  Created by TTN on 30/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
        
   
    @IBOutlet weak var titleLabel: UILabel!
    
   
    @IBOutlet weak var genreCollectionView: UICollectionView!
        
        var movieInfo: [MovieInfo]?
        
        static let identifier = "TableViewCell"
        
        static func nib() -> UINib {
            return UINib(nibName: "TableViewCell", bundle: nil)
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
           
            self.selectionStyle = .none
            genreCollectionView.register(MainCollectionViewCell.nib(), forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
            
            genreCollectionView.layer.cornerRadius = 10
            genreCollectionView.layer.shadowColor = UIColor.gray.cgColor
            genreCollectionView.layer.shadowOpacity = 1
            genreCollectionView.layer.shadowOffset = .zero
            genreCollectionView.layer.shadowRadius = 10
            genreCollectionView.delegate = self
            genreCollectionView.dataSource = self
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
        }
        
        func configure(_ data: HomeData){
            titleLabel.text = data.sectionTitle
            movieInfo = data.movieInfo
            genreCollectionView.reloadData()
            //buttonAction()
        }

    }

    extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return movieInfo?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = genreCollectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
            cell.configure(movieInfo?[indexPath.row])
            return cell
            
        }
        
        
    }



    
