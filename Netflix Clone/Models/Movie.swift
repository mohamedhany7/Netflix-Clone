//
//  Movie.swift
//  Netflix Clone
//
//  Created by Mohamed Hany on 08/01/2023.
//

import Foundation

struct TrendingMoviesResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let title: String?
    let vote_average: Double
    let vote_count: Int
    let popularity: Double
}
