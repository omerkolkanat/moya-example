//
//  NetworkManager.swift
//  MoyaExample
//
//  Created by Ömer Kolkanat on 16.05.2020.
//  Copyright © 2020 Omer Kolkanat. All rights reserved.
//

import Moya

protocol Networkable {
    var provider: MoyaProvider<API> { get }

    func fetchPopularMovies(completion: @escaping (Result<MovieResponse, Error>) -> ())
    func fetchMovieDetail(movieId: String, completion: @escaping (Result<MovieDetailResponse, Error>) -> ())
    func fetchSearchResult(query: String, completion: @escaping (Result<SearchResponse, Error>) -> ())
}

class NetworkManager: Networkable {
    var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])

    func fetchPopularMovies(completion: @escaping (Result<MovieResponse, Error>) -> ()) {
        request(target: .popular, completion: completion)
    }
    
    func fetchMovieDetail(movieId: String, completion: @escaping (Result<MovieDetailResponse, Error>) -> ()) {
        request(target: .movie(movieId: movieId), completion: completion)
    }
    
    func fetchSearchResult(query: String, completion: @escaping (Result<SearchResponse, Error>) -> ()) {
        request(target: .search(query: query), completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: API, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
