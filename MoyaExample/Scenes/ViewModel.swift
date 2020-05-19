//
//  ViewModel.swift
//  MoyaExample
//
//  Created by Ömer Kolkanat on 19.05.2020.
//  Copyright © 2020 Omer Kolkanat. All rights reserved.
//

protocol ViewModelProtocol: class {
    func didUpdatePopularMovies()
    func didUpdateMovieDetail()
    func didUpdateSearchResult()
}

class ViewModel {
    weak var delegate: ViewModelProtocol?
    
    fileprivate(set) var popularMovies: [MovieResult]? = []
    fileprivate(set) var movieDetail: MovieDetailResponse?
    fileprivate(set) var searchResponse: SearchResponse?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func loadPopularMovies() {
        networkManager.fetchPopularMovies { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let movieResponse):
                if let popularMovies = movieResponse.results {
                    strongSelf.popularMovies = popularMovies
                    strongSelf.delegate?.didUpdatePopularMovies()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadMovieDetail(movieId: String) {
        networkManager.fetchMovieDetail(movieId: movieId, completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let movieDetailResponse):
                strongSelf.movieDetail = movieDetailResponse
                strongSelf.delegate?.didUpdateMovieDetail()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func search(with query: String) {
        networkManager.fetchSearchResult(query: query, completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let searchResponse):
                strongSelf.searchResponse = searchResponse
                strongSelf.delegate?.didUpdateSearchResult()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
