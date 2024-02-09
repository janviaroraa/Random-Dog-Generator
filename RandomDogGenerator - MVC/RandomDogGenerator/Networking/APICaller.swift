//
//  APICaller.swift
//  RandomDogGenerator
//
//  Created by Janvi Arora on 09/02/24.
//

import Foundation

/// Singleton class used to fetch data from server
class APICaller {

    static let shared: APICaller = APICaller()

    private init() {}

    func fetchRandomDog(completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: Constants.URL) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }

            do {
                let result = try JSONDecoder().decode(DogResponseModal.self, from: data)
                completion(.success(result.message))
            } catch {
                completion(.failure(.decodingError))
            }
        }

        task.resume()
    }
}


