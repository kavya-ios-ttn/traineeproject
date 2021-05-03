//
//  NetworkManager.swift
//  TraineeProject
//
//  Created by TTN on 02/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation


//class NetworkManager has two major components API Call and APIConstants
//consists of MainData, MovieData and HomeData which are inside MovieDataModel


class NetworkManager {
    
    //used @escaping closure because until the entire data is not shown, the closure keeps saving the data
    //it captures the entire data and then returns
    //In this case, data doesn't break
    //Keeps working separately until all the data has been fetched
    
    func fetchApiData(urlType: ApiConstants, completion: @escaping (Result<MainData,Error>) -> Void){
            let url = URL(string: urlType.finalUrl)!
            APICall().request(url, for: MainData.self) { (result) in
                //A completion closure is taken 
                completion(result)
            }
        }
        
        func fetchUserData(urlType: ApiConstants, completion: @escaping (Result<[Int],Error>) -> Void){
            let url = URL(string: urlType.finalUrl)!
            APICall().request(url, for: [Int].self) { (result) in
                completion(result)
            }
        }
    }

    
