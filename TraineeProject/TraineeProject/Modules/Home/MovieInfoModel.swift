//
//  MovieInfoModel.swift
//  TraineeProject
//
//  Created by TTN on 02/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation

struct HomeData {
    let sectionTitle: String?
    let movieInfo: [MovieInfo]?
}

struct MainData: Decodable {
//    let page: Int?
    let results: [MovieInfo]?
//    let total_pages, total_results: Int?
}

// MARK: - Result
struct MovieInfo: Decodable {
//    let adult: Bool?
    let backdrop_path: String?
//    let genre_ids: [Int]?
//    let id: Int?
//    let original_language: String?
//    let original_title, overview: String?
//    let popularity: Double?
    let poster_path, release_date, title: String?
//    let video: Bool?
//    let vote_average, vote_count: Int?
}
