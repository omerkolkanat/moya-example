//
//  API.swift
//  MoyaExample
//
//  Created by Ömer Kolkanat on 12.05.2020.
//  Copyright © 2020 Omer Kolkanat. All rights reserved.
//

import Moya

enum API {
    case popular
    case movie(movieId: String)
    case search(query: String)
}

extension API: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .movie(let movieId):
            return "movie/\(movieId)"
        case .search:
            return "search/movie"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .popular, .movie:
            return .requestParameters(parameters: ["api_key": Constants.API.apiKey], encoding: URLEncoding.queryString)
        case .search(let query):
            return .requestParameters(parameters: ["query" : query, "api_key": Constants.API.apiKey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
