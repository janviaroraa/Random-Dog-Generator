//
//  RecentlyGeneratedViewController+CollectionView.swift
//  RandomDogGenerator
//
//  Created by Janvi Arora on 09/02/24.
//

import UIKit

extension RecentlyGeneratedViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageDownloader.shared.imageCache.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let imageUrls = Array(ImageDownloader.shared.imageCache.keys)
        
        if indexPath.item < imageUrls.count {
            let imageUrl = imageUrls[indexPath.item]
            if let cachedImage = ImageDownloader.shared.imageCache[imageUrl] {
                let imageView = UIImageView(image: cachedImage)
                imageView.contentMode = .scaleAspectFit
                imageView.frame = cell.contentView.bounds
                imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                cell.contentView.addSubview(imageView)
            }
        }

        return cell
    }
}
