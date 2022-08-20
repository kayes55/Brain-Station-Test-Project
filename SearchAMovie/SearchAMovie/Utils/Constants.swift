//
//
// SearchAMovie
// Running on MacOS Version 12.4
// Swift Version 5.0
// Created by kayes on 8/12/22
// Copyright © IMRUL KAYES. All rights reserved.


import Foundation

import Foundation

struct Constants {
    
    static let notAvailable = "N/A"
    
    struct Icons {
        static let appLogo = "Logo"
    }

    struct Search {
        static let emptyStateWelcomeText = "Welcome! Type a movie name to start."
        static let emptyStateNoResultsText = "Sorry! We couldn't find any results."
        static let placeholder = "Search movies"
        static let noResultsImage = "NoResults"
    }
    struct Alerts {
        static let defaultTitle = "Oops"
        static let defaultButtonTitle = "OK"
        static let tryAgainButtonTitle = "Try Again"
    }
    struct Identifiers {
        static let MovieCell = "MovieCell"
    }
    struct ApiImageURL {
        static let highQuality = "https://image.tmdb.org/t/p/w780"
        static let mediumQuality = "https://image.tmdb.org/t/p/w342"
        static let lowQuality = "https://image.tmdb.org/t/p/w154"
        static let posterPlaceholder = "https://critics.io/img/movies/poster-placeholder.png"
        static let backdropPlaceholder = "https://image.xumo.com/v1/assets/asset/XM05YG2LULFZON/600x340.jpg"
    }
}
