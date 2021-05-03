//
//  APIConstants.swift
//  TraineeProject
//
//  Created by TTN on 02/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation

enum ApiConstants {
    
    case home(genre)
    case user
    
    //Case iterable means that it iterates on its own
    //Fetching happens asynchronously which means that the data that comes first is shown first
    
    //created an anum of of all the contents that will be dislayed on the collection view
    
    enum genre: String, CaseIterable {
        
        case banner = "Banner"
        case popularity = "Popularity"
        case bestDrama = "Best Drama"
        case kidsMovies = "Kids Movies"
        case bestMovies = "Best Movies"
        
    }
    
    //created a final URL which consists of all 3 parts of the API
    
    var finalUrl: String{
        return baseUrl + endUrl + apiKey
    }
    
    //created a base URL which is the complete API URL and is same for all API
    
    var baseUrl: String {
        switch self {
        case .home(_):
            return "https://api.themoviedb.org/3/"
        case .user:
            return ""
        
        }
    }
    
    //created an end URL which is the middle part of the URL according to the genres
    
    var endUrl: String {
        switch self {
        case .home(let genre):
            switch  genre {
            case .banner:
                return "trending/movie/day?"
            case .popularity:
                return "discover/movie?sort_by=popularity.desc"
            case .bestDrama:
                return "discover/movie?with_genres=18&sort_by=vote_average.desc&vote_count.gte=10"
            case .kidsMovies:
                return "discover/movie?certification_country=US&certification.lte=G&sort_by=vote_average.desc"
            case .bestMovies:
                return "discover/movie?primary_release_year=2010&sort_by=vote_average.desc"
            }
        case .user:
            return ""
        
        }
    }
    
    //API key is common for all. It is like a lock of all the URLs.
    //URLs cannot be accessed without an API key
    
    var apiKey: String {
        
        switch self {
        case .home(_):
            return "&api_key=820016b7116f872f5f27bf56f9fdfb66"
        case .user:
            return ""
        
        }
    }
}
