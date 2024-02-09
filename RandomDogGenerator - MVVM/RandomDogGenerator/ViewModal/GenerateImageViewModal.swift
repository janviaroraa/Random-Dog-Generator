//
//  GenerateImageViewModal.swift
//  RandomDogGenerator
//
//  Created by Janvi Arora on 09/02/24.
//

import UIKit

class GenerateImageViewModel {

    var onImageFetch: ((UIImage?) -> Void)?

    func generateRandomDog() {
        APICaller.shared.fetchRandomDog { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let imageURL):
                if let url = URL(string: imageURL) {
                    ImageDownloader.shared.loadImageFromURL(url: url) { image in
                        self.onImageFetch?(image)
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
                self.onImageFetch?(nil)
            }
        }
    }
}

