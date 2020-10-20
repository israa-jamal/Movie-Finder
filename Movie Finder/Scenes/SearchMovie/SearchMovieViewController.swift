//
//  SearchMovieViewController.swift
//  Movie Finder
//
//  Created by Esraa Gamal on 10/18/20.
//  Copyright (c) 2020 Esraa Gamal. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SearchMovieDisplayLogic: class
{
    func displaySomething(viewModel: SearchMovie.Something.ViewModel)
}

class SearchMovieViewController: UIViewController, SearchMovieDisplayLogic{
    var interactor: SearchMovieBusinessLogic?
    var router: (NSObjectProtocol & SearchMovieRoutingLogic & SearchMovieDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = SearchMovieInteractor()
        let presenter = SearchMoviePresenter()
        let router = SearchMovieRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         navigationController?.isNavigationBarHidden = true
     }
     
     //display the navigation bar before going to the next views
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         navigationController?.isNavigationBarHidden = false
     }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomething()
        configureUI()
    }
    
    // MARK: UIView Components
    
    //Outlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchFieldView: UIView!
    @IBAction func searchButton(_ sender: UIButton) {
        router?.routeToListView(segue: nil)
    }
    var movieBrain = MovieBrain()

    
    private func configureUI(){
         
        searchFieldView.layer.cornerRadius = 20
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search a movie..", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white ])
        self.searchTextField.delegate = self
//        self.movieBrain.delegate = self
    }
    
    func doSomething()
    {
        let request = SearchMovie.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: SearchMovie.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
}

//MARK:- TextField

extension SearchMovieViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        router?.routeToListView(segue: nil)
        return true
    }
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           if textField.text != ""
           {
               return true
           }else
           {
               textField.placeholder = "Search a movie.."
               return false
           }
           
       }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let movie = textField.text {
            movieBrain.fetchMovie(movie)
        }
        searchTextField.text = ""
    }
    
}

