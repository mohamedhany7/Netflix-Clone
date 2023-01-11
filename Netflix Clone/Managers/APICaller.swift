//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Mohamed Hany on 08/01/2023.
//

import Foundation

struct constants {
    static let API_KEY = "f0a32852362997293da26bee08f59f2d"
    static let baseUrl = "https://api.themoviedb.org"
}

enum APIError : Error{
    case failedToGetData
}

enum sections: Int{
    case trendingMovie = 0
    case trendingTv = 1
    case popular = 2
    case upcomingMovies = 3
    case topRated = 4
}


class APICaller {
    static let shared = APICaller()
    
    func getFromEndPoint(type: Int, complition: @escaping (Result<[Movie], Error>) -> Void){
        guard let url = URL(string: generateUrl(type: type)) else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                complition(.success(results.results))
            } catch {
                complition(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func generateUrl(type: Int) -> String{
        var link : String
        
        switch type {
        case sections.trendingMovie.rawValue:
            link = "/3/trending/movie/day?api_key="
        case sections.trendingTv.rawValue:
            link = "/3/trending/tv/day?api_key="
        case sections.popular.rawValue:
            link = "/3/movie/popular?api_key="
        case sections.upcomingMovies.rawValue:
            link = "/3/movie/upcoming?api_key="
        case sections.topRated.rawValue:
            link = "/3/movie/top_rated?api_key="
        default:
            link = ""
        }
        
        let url = "\(constants.baseUrl)\(link)\(constants.API_KEY)"
        return url
    }
}
