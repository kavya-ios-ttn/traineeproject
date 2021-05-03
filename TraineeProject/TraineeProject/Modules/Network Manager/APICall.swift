//
//  APICall.swift
//  TraineeProject
//
//  Created by TTN on 02/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation

class APICall {
    
    //API call is used for hitting the API with a function request which is newly introduced in Swift 5
        
    let session = URLSession.shared
    
    //Whenever we call API, either it will be a fail or a success.
    //In case of fail, result is a generic method which has two components, success or failure
        
    func request<T: Decodable>(_ url: URL, for dataType: T.Type , completion: @escaping (Result<T,Error>) -> Void )  {
            let sessionTask = session.dataTask(with: url ) { (data, response, error) in
                if let apiError = error{
                    
                    //In DispatchQueue.main.async, the moment the API is hit, the data is showed on the UI simultaneously
                    
                    DispatchQueue.main.async {
                        completion(.failure(apiError))
                    }
                } else if let apiData = data{
                    do {
                        //JSONDecoder is used because it maps every data type with the help of a generic function called result
                        //So it is decodable because it decodes API data
                        
                        let parseData = try JSONDecoder().decode(dataType, from: apiData)
                        DispatchQueue.main.async {
                            completion(.success(parseData))
                        }
                    }catch {
                        DispatchQueue.main.async {
                            completion(.failure(NSError.init(domain: "Failed To parse Data", code: 1, userInfo: nil)))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(NSError.init(domain: "Some Error Occured", code: 1, userInfo: nil)))
                    }
                }
            }
            sessionTask.resume()
        }
        
        func stopAllRequests() {
            session.invalidateAndCancel()
        }
        
    }

