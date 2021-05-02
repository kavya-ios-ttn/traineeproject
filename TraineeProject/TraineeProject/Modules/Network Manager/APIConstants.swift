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
    
    enum genre: String, CaseIterable {
        case popularity = "popularity"
        case bestDrama = "bestDrama"
        case kidsMovies = "kidsMovies"
        case bestMovies = "bestMovies"
    }
    var finalUrl: String{
        return baseUrl + endUrl + apiKey
    }
    
    var baseUrl: String {
        switch self {
        case .home(_):
            return "https://api.themoviedb.org/3/"
        case .user:
            return ""
        
        }
    }
    var endUrl: String {
        switch self {
        case .home(let genre):
            switch  genre {
            case .popularity:
                return "discover/movie?sort_by=popularity.desc"
            case .bestDrama:
                return "discover/movie?with_genres=18&sort_by=vote_average.desc&vote_count.gte=10"
            case .kidsMovies:
                return "discover/movie?certification_country=US&certification.lte=G&sort_by=popularity.desc"
            case .bestMovies:
                return "discover/movie?primary_release_year=2010&sort_by=vote_average.desc"
            }
        case .user:
            return ""
        
        }
    }
    var apiKey: String {
        
        switch self {
        case .home(_):
            return "&api_key=820016b7116f872f5f27bf56f9fdfb66"
        case .user:
            return ""
        
        }
    }
}

