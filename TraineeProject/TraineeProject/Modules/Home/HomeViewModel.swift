//
//  HomeViewModel.swift
//  TraineeProject
//
//  Created by TTN on 02/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    //created a homeAPIData which stores everything
    var homeApiData: [HomeData] = []
    
    func fetchHomeApiData(completion: @escaping (Bool,String) -> Void){
        
        homeApiData.removeAll()
        
                //genre.allCases means that if genre == .banner, append the data of the banner first
        
                for genre in ApiConstants.genre.allCases {
                    NetworkManager().fetchApiData(urlType: .home(genre)) { (result) in
                        switch result{
                        case .success(let data):
                            if genre == .banner {
                                self.homeApiData.insert(HomeData(sectionTitle: genre.rawValue, movieInfo: data.results), at: 0)
                            } else {
                                self.homeApiData.append(HomeData(sectionTitle: genre.rawValue, movieInfo: data.results))
                            }
                            
                            //if completion is true, data will be appended in different table view cells
                            
                            completion(true, "")
                        case .failure(let error):
                            completion(false, error.localizedDescription)
                        }
                    }
                }
            }
            
        }
