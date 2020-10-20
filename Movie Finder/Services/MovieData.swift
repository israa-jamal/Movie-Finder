//
//  Data.swift
//  Movie Finder
//
//  Created by Esraa Gamal on 10/19/20.
//  Copyright © 2020 Esraa Gamal. All rights reserved.
//

import Foundation

struct MovieData : Codable {
    let results : [Results]
}
struct Results : Codable
{
    let title : String
    let release_date : String
    let poster_path : String
    let overview : String
}
