//
//  DataManager.swift
//  Netflix Clone
//
//  Created by Mohamed Hany on 24/01/2023.
//

import Foundation
import UIKit
import CoreData

class DataManager{
    enum DatabaseError: Error{
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataManager()
    
    func downloadMovieWith(model: Movie, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let movie = MovieItem(context: context)
        
        movie.id = Int64(model.id)
        movie.original_name = model.original_name
        movie.original_title = model.original_title
        movie.overview = model.overview
        movie.poster_path = model.poster_path
        movie.popularity = model.popularity
        movie.title = model.title
        movie.media_type = model.media_type
        movie.release_date = model.release_date
        movie.vote_average = model.vote_average
        movie.vote_count = Int64(model.vote_count)
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func fetchMoviesFromDatabase(complition: @escaping (Result<[MovieItem], Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<MovieItem>
        request = MovieItem.fetchRequest()
        
        do{
            let movies = try context.fetch(request)
            complition(.success(movies))
        } catch{
            complition(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteMovie(with model: MovieItem, complition: @escaping (Result<Void,Error>)-> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        do{
            context.delete(model)
            try context.save()
            complition(.success(()))
        } catch{
            complition(.failure(DatabaseError.failedToDeleteData))
        }
    }
}
