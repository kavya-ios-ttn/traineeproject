//
//  APIIntegration.swift
//  TraineeProject
//
//  Created by TTN on 30/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation
import UIKit

struct MainData: Decodable {
    var page: Int
    var results: [movieInfo]
    var total_pages: Int
    var total_results: Int
}

struct movieInfo: Decodable {
    var adult: Bool
    var genre_type: [Int]
    var id: Int
    var original_language: String
    var original_title: String
    var about: String
    var popularity: Double
    var poster: String
    var release_date: String
    var title: String
    var video: Bool
    var fav: String
}

extension UIImageView {
    func download(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType,
                mimeType.hasPrefix("image"),
                let data = data,
                error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() {
                [weak self] in self?.image = image
            }
        }.resume()
            
            
        }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        download(url: url, contentMode: mode)
    }
}

class APIIntegration {
    let homeImageUrl = "https://image.tmdb.org/t/p/w500"
    
    var info: MainData?
    
    func JSONDownload(completed: @escaping ([movieInfo]) -> Void) {
        let homeUrl: String = "https://api.themoviedb.org/3/"
        let popular: String = "discover/movie?sort_by=popularity.desc"
        //paths to specific links will be defines with their respective use cases
        let apiKey: String = "&api_key=820016b7116f872f5f27bf56f9fdfb66"
        let finalUrl = URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=820016b7116f872f5f27bf56f9fdfb66")
        
        URLSession.shared.dataTask(with: finalUrl!) {
            (data, response, error) in
            if error == nil {
                do {
                    self.info = try
                        JSONDecoder().decode(MainData.self, from: data!)
                    DispatchQueue.main.async {
                        completed(self.info!.results)
                    }
                } catch {
                    print("JSON Not Found")
                }
            }
        }.resume()
}

    func genreCategory() {
    }
}
