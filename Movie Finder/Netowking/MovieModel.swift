//
//  MovieModel.swift
//  Movie Finder
//
//  Created by Esraa Gamal on 10/22/20.
//  Copyright © 2020 Esraa Gamal. All rights reserved.
//

import Foundation

struct MovieModel : Codable {
    let movies : [Movie]
    private enum CodingKeys: String, CodingKey{
        case movies = "results"
    }
}
struct Movie : Codable
{
    let title : String
    let release_date : String
    let poster_path : String
    let overview : String
    let vote_average : Double
}


