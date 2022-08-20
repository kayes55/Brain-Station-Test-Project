//
//
// SearchAMovie
// Running on MacOS Version 12.4
// Swift Version 5.0
// Created by kayes on 8/12/22
// Copyright © IMRUL KAYES. All rights reserved.


import Foundation

enum ErrorHandler: Error {
    case decode
    case invalidURL
    case invalidData
    case noResponse
    case unauthorized
    case notFound
    case unexpectedStatusCode
    case badRequest
    case serverError
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "We have a little problem decoding data."
        case .invalidURL:
            return "You are trying to fetch a invalid URL."
        case .invalidData:
            return "You get a invalid response from the server, bro!"
        case .noResponse:
            return "No internet! The API doesn't give me a response."
        case .badRequest:
            return "Bad request! You provided wrong information to the server."
        case .unauthorized:
            return "401: You don't have authorization to access this content."
        case .notFound:
            return "404: The URL that you are trying to fetch doesn't exist."
        case .serverError:
            return "500:  Internal [RIP] Server Error"
        case .unexpectedStatusCode:
            return "Oh god! I don't recognize this status code. Please, contact the backend guy."
        default:
            return "Unknown error"
        }
    }
}
