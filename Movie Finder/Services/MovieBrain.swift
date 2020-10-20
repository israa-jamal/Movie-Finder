//
//  Networking.swift
//  Movie Finder
//
//  Created by Esraa Gamal on 10/19/20.
//  Copyright © 2020 Esraa Gamal. All rights reserved.
//

import Foundation
protocol MovieBrainDelegate {
    func setMovie(_ movieBrain : MovieBrain ,movie : MovieModel)
    func didFailWithError (_ error : Error)
}

struct MovieBrain {
    var delegate : MovieBrainDelegate?
    let movieDetailsURL = "https://api.themoviedb.org/3/search/movie?api_key=b3070a5d3abfb7c241d2688d066914e7"
    func fetchMovie(_ movie: String){
        let movieURL = "\(movieDetailsURL)&query=\(movie)&page=1"
        performRequest(movieURL)
    }

    func performRequest (_ urlString : String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if  error != nil{
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data{
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString)
                    if let movie = self.parseJSON(safeData){
                        self.delegate?.setMovie(self, movie : movie)
                    }
                }
            }
            task.resume()
        }
    }
    //decoding data from the url
    func parseJSON(_ movieData: Data) ->MovieModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(MovieData.self, from: movieData)
            let title = decodedData.results[0].title
            let relaseDate = decodedData.results[0].title
            let overview = decodedData.results[0].overview
            let posterResult = decodedData.results[0].poster_path
            let poster = "http://image.tmdb.org/t/p/w92/\(posterResult)"
            let movie = MovieModel(movieTitle: title, relaseDate: relaseDate, MovieOverview: overview, moviePoster: poster)
            return movie
            
             
        }
        catch{
            delegate?.didFailWithError(error)
            return nil
        }
        
        
        }
    }
