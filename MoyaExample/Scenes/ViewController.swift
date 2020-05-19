//
//  ViewController.swift
//  MoyaExample
//
//  Created by Ömer Kolkanat on 12.05.2020.
//  Copyright © 2020 Omer Kolkanat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.loadPopularMovies()
        viewModel.loadMovieDetail(movieId: "299536")
        viewModel.search(with: "breaking")
    }
}

extension ViewController: ViewModelProtocol {
    func didUpdatePopularMovies() {
        print(viewModel.popularMovies)
    }
    
    func didUpdateMovieDetail() {
        print(viewModel.movieDetail)
    }
    
    func didUpdateSearchResult() {
        print(viewModel.searchResponse)
    }
}

