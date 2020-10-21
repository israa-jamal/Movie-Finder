//
//  SearchMovie1Configurator.swift
//  Movie Finder
//
//  Created by Esraa Gamal on 10/21/20.
//  Copyright (c) 2020 Esraa Gamal. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//  https://github.com/HelmMobile/clean-swift-templates

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension SearchMovieInteractor: SearchMovieViewControllerOutput, SearchMovieRouterDataSource, SearchMovieRouterDataDestination {
}

extension SearchMoviePresenter: SearchMovieInteractorOutput {
}

class SearchMovieConfigurator {
    // MARK: Object lifecycle
    
    static let sharedInstance = SearchMovieConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: SearchMovieViewController) {
        
        let presenter = SearchMoviePresenter()
        presenter.output = viewController
        
        let interactor = SearchMovieInteractor()
        interactor.output = presenter
        
        let router = SearchMovieRouter(viewController: viewController, dataSource: interactor, dataDestination: interactor)
        
        viewController.output = interactor
        viewController.router = router
    }
}
