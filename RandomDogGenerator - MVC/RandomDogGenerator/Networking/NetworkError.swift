//
//  NetworkError.swift
//  RandomDogGenerator
//
//  Created by Janvi Arora on 09/02/24.
//

import Foundation

/// Enum to handle error cases
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
