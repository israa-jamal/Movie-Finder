//
//  API.swift
//  Movie Finder
//
//  Created by Esraa Gamal on 10/22/20.
//  Copyright © 2020 Esraa Gamal. All rights reserved.
//

import Foundation

class APIWorker{
    
 private var dataTask: URLSessionDataTask?

    func getMovie(page: Int, movie : String, completion: @escaping (Result<MovieModel, Error>) -> Void){
        let movieURL = "https://api.themoviedb.org/3/search/movie?api_key=b3070a5d3abfb7c241d2688d066914e7&query=\(movie)&page=\(page)"
        guard let url = URL(string: movieURL) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url){ (data,response,error) in
            
            if let error = error{
                completion(.failure(error))
                print(error)
                return
            }
            guard let response = response as? HTTPURLResponse else{
                print("there is no response")
                return
            }
            print("response status code \(response.statusCode)")
            guard let data = data else {
                print("there is no data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(MovieModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            }catch let error{
                completion(.failure(error))
            }
        }
        dataTask?.resume()
        
    }
}
