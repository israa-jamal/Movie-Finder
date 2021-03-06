//
//  MovieListPresenter.swift
//  Movie Finder
//
//  Created by Esraa Gamal on 10/21/20.
//  Copyright (c) 2020 Esraa Gamal. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//  https://github.com/HelmMobile/clean-swift-templates

protocol MovieListPresenterInput {
    func passDataToModeling(movies: [Movie])
}

protocol MovieListPresenterOutput: class {
    func presentData(movies: [MovieListModel.ViewModel])
}

class MovieListPresenter: MovieListPresenterInput {
   
    weak var output: MovieListPresenterOutput?
    
    // MARK: Presentation logic
    func passDataToModeling(movies: [Movie]) {
        var moviesArray : [MovieListModel.ViewModel] = []
        var i = 0
        for _ in movies{
            let movie = MovieListModel.ViewModel(movieTitle: movies[i].title, relaseDate: movies[i].release_date, MovieOverview: movies[i].overview, moviePoster: movies[i].poster_path)
            moviesArray.append(movie)
            i += 1
        }
        output?.presentData(movies: moviesArray)
    }
    
}
