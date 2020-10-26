//
//  MovieCell.swift
//  Movie Finder
//
//  Created by Esraa Gamal on 10/18/20.
//  Copyright © 2020 Esraa Gamal. All rights reserved.
//

import UIKit

//protocol MovieCellViewInput {
//        func presentData(movies: [MovieListModel.ViewModel])
//
//}
//protocol MovieCellViewOutput{
//
//}
class MovieCell: UITableViewCell{
//    func presentData(movies: [MovieListModel.ViewModel]) {
//
//    }
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var relaseDateLabel: UILabel!
    @IBOutlet weak var movieDiscriptionLabel: UILabel!
    
    private var urlString : String = ""
    
    func setCellWithValues(movie: MovieListModel.ViewModel){
        updateUI(title: movie.movieTitle, relaseDate: movie.relaseDate, overView: movie.MovieOverview, poster: movie.moviePoster)
    }
    private func updateUI(title: String?, relaseDate: String?, overView: String?, poster: String?){
        self.movieTitleLabel.text = title
        self.relaseDateLabel.text = convertDate(relaseDate)
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
    func convertDate(_ date : String?)-> String {
        var fixedDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate){
                dateFormatter.dateFormat = "yyyy"
                fixedDate = dateFormatter.string(from: newDate)
            }
        }
        return fixedDate
    }
}


