//
//  SearchMovie1Router.swift
//  Movie Finder
//
//  Created by Esraa Gamal on 10/21/20.
//  Copyright (c) 2020 Esraa Gamal. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//  https://github.com/HelmMobile/clean-swift-templates

import UIKit

protocol SearchMovieRouterInput {
    
}

protocol SearchMovieRouterDataSource: class {
    
}

protocol SearchMovieRouterDataDestination: class {
    
}

class SearchMovieRouter: SearchMovieRouterInput {
    
    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
    weak var viewController: SearchMovieViewController!
    weak private var dataSource: SearchMovieRouterDataSource!
    weak var dataDestination: SearchMovieRouterDataDestination!
    
    init(viewController: SearchMovieViewController, dataSource: SearchMovieRouterDataSource, dataDestination: SearchMovieRouterDataDestination) {
        self.viewController = viewController
        self.dataSource = dataSource
        self.dataDestination = dataDestination
    }
    
    // MARK: Navigation
    func navigateToMovieList(source: SearchMovieViewController, destination: MovieListViewController)
    {
        source.show(destination, sender: nil)
    }
    // MARK: Communication
    
    func passDataToNextScene(for segue: UIStoryboardSegue) {
        // NOTE: Teach the router which scenes it can communicate with
        
    }
    func navigateToMovieList(navigationController : UINavigationController?){
        let movieListVC = mainStoryBoard.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        if let movie = viewController.output?.searchedMovie{
            movieListVC.output?.searchedMovie = movie
        navigationController?.pushViewController(movieListVC, animated: true)
        }else{
            print("error")
        }
    
    }
}
