//
//
// SearchAMovie
// Running on MacOS Version 12.5
// Swift Version 5.0
// Created by kayes on 8/20/22
// Copyright © IMRUL KAYES. All rights reserved.


import Foundation

protocol MoviesServiceProtocol {
    typealias ResultMovies = (Result<Movies, ErrorHandler>)

    func searchMovie(query: String, completion: @escaping (ResultMovies) -> Void)
}

final class MoviesService: MoviesServiceProtocol {
    
    static let shared = MoviesService()
    
    private let httpClient: HttpClientProtocol
    
    init(httpClient: HttpClientProtocol = HttpClient.shared) {
        self.httpClient = httpClient
    }
    
    func searchMovie(query: String, completion: @escaping (ResultMovies) -> Void) {
        httpClient.request(endpoint: MoviesEndpoint.searchMovie(query: query),
                           model: Movies.self,
                           completion: completion)
    }
    
    
}
