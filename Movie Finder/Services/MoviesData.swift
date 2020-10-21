////
////  Data.swift
////  Movie Finder
////
////  Created by Esraa Gamal on 10/19/20.
////  Copyright © 2020 Esraa Gamal. All rights reserved.
////
//
import Foundation

struct MoviesData : Codable {
    let movies : [Movie]
    private enum CodingKeys: String, CodingKey{
        case movies = "results"
    }
}

struct Movie : Codable
{
    var title : String?
    var releaseDate : String?
    var posterPath: String?
    var rate : Double?
    var overview : String?
    
    enum CodingKeys: String, CodingKey{
        case title
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case rate = "vote_average"
        
    }
}
