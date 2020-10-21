//
//  MovieModel.swift
//  Movie Finder
//
//  Created by Esraa Gamal on 10/19/20.
//  Copyright © 2020 Esraa Gamal. All rights reserved.
//
//
import Foundation

class MovieViewModel{
    
    private var api = API()
    private var searchedMovies = [Movie]()
    
    func fetchMoviesData(completion: @escaping () ->()){
        api.getMovie { [weak self] (result) in
            switch result{
            case .success(let listOf):
                self?.searchedMovies = listOf.movies
                completion()
            case.failure(let error):
                print("error processing data\(error)")
                
            }
        }
    }
    func numberOfRowInSection(section: Int) -> Int{
        if searchedMovies.count != 0{
            return searchedMovies.count
        }
        return 0
    }
    func cellForRowAt(indexPath: IndexPath) -> Movie{
        return searchedMovies[indexPath.row]
    }
}
