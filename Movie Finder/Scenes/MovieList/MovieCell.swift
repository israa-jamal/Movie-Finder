//
//  MovieCell.swift
//  Movie Finder
//
//  Created by Esraa Gamal on 10/18/20.
//  Copyright © 2020 Esraa Gamal. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell{
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var relaseDateLabel: UILabel!
    @IBOutlet weak var movieDiscriptionLabel: UILabel!
    
    private var urlString : String = ""
    func setCellWithValues(movie: Movie){
        updateUI(title: movie.title, relaseDate: movie.releaseDate, overView: movie.overview, poster: movie.posterPath)
    }
    private func updateUI(title: String?, relaseDate: String?, overView: String?, poster: String?){
        self.movieTitleLabel.text = title
        self.relaseDateLabel.text = relaseDate
        self.movieDiscriptionLabel.text = overView
        guard let posterString = poster else {return}
        urlString = "https://image.tmdb.org/t/p/w92/" + posterString
        guard let posterImageURl = URL(string: urlString) else {
            self.movieImageView.image = UIImage(named: "noImageAvailable")
            return
        }
        self.movieImageView.image = nil
        self.getImageData(from: posterImageURl)
    }
    
    //getting image data
    private func getImageData(from url : URL){
        URLSession.shared.dataTask(with: url){(data,response,error) in
                
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                guard let data = data else {
                    print("there is no data")
                    return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                self.movieImageView.image = image
            }
                
            }

        }
        .resume()

    }
    
}


