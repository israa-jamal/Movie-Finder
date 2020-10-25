//
//  SearchMovie1ViewController.swift
//  Movie Finder
//
//  Created by Esraa Gamal on 10/21/20.
//  Copyright (c) 2020 Esraa Gamal. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//  https://github.com/HelmMobile/clean-swift-templates

import UIKit


protocol SearchMovieViewControllerInput {
}

protocol SearchMovieViewControllerOutput {
    var searchedMovie: String? {set get}
}

class SearchMovieViewController: UIViewController, SearchMovieViewControllerInput {
    
    //Outlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchFieldView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight : NSLayoutConstraint!
    
   
    //Proprites
    var output: SearchMovieViewControllerOutput?
    var router: SearchMovieRouter?
    var results : [Movie]?
    var searchHistory = SearchHistory()
    
    // MARK: Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SearchMovieConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        loadHistory()
    }
    
    //display the navigation bar before going to the next views
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    func loadHistory(){
            SearchHistory.history = self.searchHistory.defaults.array(forKey: "history") as! [String]
        tableView.alpha = 0
        tableViewHeight.constant = CGFloat(searchHistory.getHistoryElementsCount() * 50)
        tableView.reloadData()
    }
    private func configureUI(){
        searchFieldView.layer.cornerRadius = 20
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search a movie..", attributes: [NSAttributedString.Key.foregroundColor : UIColor(white:1, alpha: 0.75)])
        self.searchTextField.delegate = self
        
    }
    
    // MARK: Requests
    
    
    // MARK: Display logic
    @IBAction func searchButton(_ sender: UIButton) {
        if checkIfTextFieldIsNotEmpty(){
            output?.searchedMovie = searchTextField.text
            router?.navigateToMovieList(navigationController: navigationController)
        }
    }
}

//This should be on configurator but for some reason storyboard doesn't detect ViewController's name if placed there
extension SearchMovieViewController: SearchMoviePresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.passDataToNextScene(for: segue)
    }
}
//MARK:- TextField

extension SearchMovieViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if checkIfTextFieldIsNotEmpty(){
            textField.resignFirstResponder()
            router?.navigateToMovieList(navigationController: navigationController)
            return true
        }
        return false
        
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
            output?.searchedMovie = movie
        }
        searchTextField.text = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4, animations: {
            self.tableView.alpha = 1
        })
        
    }
    func checkIfTextFieldIsNotEmpty() -> Bool{
        if searchTextField.text != "" {
        
            return true
        }
            self.searchTextField.placeholder = "Please write a movie name"
        return false
    }
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        if sender.text == "" {
            UIView.animate(withDuration: 0.2, animations: {
                self.tableView.alpha = 1
            })
        }else{
        tableView.alpha = 0
        }
    
       }
    
    
}

//MARK:- SearchHistoryTableView

extension SearchMovieViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistory.getHistoryElementsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        cell.searchHistoryLabel.text = searchHistory.getSearchHistoryElements(indexPath: indexPath)
        return cell
    }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            output?.searchedMovie = SearchHistory.history[indexPath.row]
            router?.navigateToMovieList(navigationController: navigationController)
//            tableView.alpha = 0
        }
}
