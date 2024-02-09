//
//  ImageDownloader.swift
//  RandomDogGenerator
//
//  Created by Janvi Arora on 09/02/24.
//

import UIKit

/// Singleton class to cache & persist data in single app session
class ImageDownloader {

    static let shared: ImageDownloader = ImageDownloader()

    var imageCache: [URL: UIImage] = [:]
    private var lruCacheOrder: [URL] = []
    private let maxCacheSize = 20

    private init() {}

    func loadImageFromURL(url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache[url] {
            completion(cachedImage)
            updateLRUCacheOrder(for: url)
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }

            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.cacheImage(image, for: url)
                    completion(image)
                }
            }
        }.resume()
    }
    
    private func cacheImage(_ image: UIImage, for url: URL) {
        if imageCache.count >= maxCacheSize, let leastRecentlyUsedURL = lruCacheOrder.first {
            imageCache.removeValue(forKey: leastRecentlyUsedURL)
            lruCacheOrder.removeFirst()
        }

        imageCache[url] = image
        lruCacheOrder.append(url)
    }

    private func updateLRUCacheOrder(for url: URL) {
        if let index = lruCacheOrder.firstIndex(of: url) {
            lruCacheOrder.remove(at: index)
            lruCacheOrder.append(url)
        }
    }

    func clearCache() {
        imageCache.removeAll()
        lruCacheOrder.removeAll()
    }
}
