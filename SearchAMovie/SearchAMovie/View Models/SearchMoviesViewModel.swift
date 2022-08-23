//
//
// SearchAMovie
// Running on MacOS Version 12.5
// Swift Version 5.0
// Created by kayes on 8/20/22
// Copyright © IMRUL KAYES. All rights reserved.


import Foundation


protocol SearchMoviesViewModelDelegate: AnyObject {
    func didFindMovies()
    func didFail(error: ErrorHandler)
    func showEmptyState()
    func showNoResultsState()
}

final class SearchMoviesViewModel {

    private let service: MoviesServiceProtocol
    
    init(service: MoviesServiceProtocol = MoviesService.shared) {
        self.service = service
    }
    
    var movies: [Movie] = []
    
    weak var delegate: SearchMoviesViewModelDelegate?
    
    func getMovie(at indexPath: IndexPath) -> Movie? {
        return !movies.isEmpty ? movies[indexPath.row] : nil
    }
    
    func backdropImageURL(of movie: Movie) -> String {
        guard let posterPath = movie.backdropPath else {
            return Constants.ApiImageURL.backdropPlaceholder
        }
        return Constants.ApiImageURL.highQuality + posterPath
    }
    
    func numberOfRows() -> Int {
        return movies.count
    }
    
    func searchMovies(with query: String) {
        let characterCount = query.count
        
        switch characterCount {
        case 0:
            self.movies = []
            self.delegate?.showEmptyState()
        default:
            service.searchMovie(query: query) { [weak self] result in
                switch result {
                case .success(let movies):
                    let noResults = movies.results.isEmpty
                    self?.movies = movies.results
                    
                    if noResults {
                        self?.delegate?.showNoResultsState()
                    } else {
                        self?.delegate?.didFindMovies()
                    }
                case .failure(let error):
                    self?.delegate?.didFail(error: error)
                }
            }
        }
    }
}
