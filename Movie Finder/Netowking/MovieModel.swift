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
    let pagesTotal : Int
    private enum CodingKeys: String, CodingKey{
        case movies = "results"
        case pagesTotal = "total_pages"
    }
}
struct Movie : Codable
{
    let title : String?
    let release_date : String?
    let poster_path : String?
    let overview : String?
    let vote_average : Double?
}


