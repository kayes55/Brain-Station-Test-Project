//
//
// SearchAMovie
// Running on MacOS Version 12.4
// Swift Version 5.0
// Created by kayes on 8/12/22
// Copyright © IMRUL KAYES. All rights reserved.


import Foundation


enum MoviesEndpoint {
    case searchMovie(query: String)
}

extension MoviesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .searchMovie:
            return "/search/movie"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .searchMovie:
            return .get
        }
    }
    
    var queryParams: [String : Any]? {
        switch self {
        case .searchMovie(let query):
            return [
                "api_key" : "38e61227f85671163c275f9bd95a8803",
                "query": query
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .searchMovie:
            return nil
        }
    }
}
