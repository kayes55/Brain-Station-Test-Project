//
//
// SearchAMovie
// Running on MacOS Version 12.5
// Swift Version 5.0
// Created by kayes on 8/20/22
// Copyright © IMRUL KAYES. All rights reserved.


import Foundation

protocol HttpClientProtocol {
    func request<T: Decodable>(endpoint: Endpoint,
                               model: T.Type,
                               completion: @escaping (Result<T, ErrorHandler>) -> Void)
}

final class HttpClient: HttpClientProtocol {
    
    static let shared = HttpClient()
    
    func request<T>(endpoint: Endpoint,
                    model: T.Type,
                    completion: @escaping (Result<T, ErrorHandler>) -> Void)
                    where T : Decodable {

        guard let url = endpoint.completeUrl else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    print("Something went wrong! \(error.localizedDescription)")
                    debugPrint(error)
                    completion(.failure(.decode))
                }
            case 400:
                completion(.failure(.badRequest))
                return
            case 401:
                completion(.failure(.unauthorized))
                return
            case 404:
                completion(.failure(.notFound))
                return
            case 500:
                completion(.failure(.serverError))
                return
            default:
                completion(.failure(.unexpectedStatusCode))
                return
            }
            
        }.resume()
    }
}
