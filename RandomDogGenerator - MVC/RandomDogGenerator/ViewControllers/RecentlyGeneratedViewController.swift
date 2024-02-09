//
//  RecentlyGeneratedViewController.swift
//  RandomDogGenerator
//
//  Created by Janvi Arora on 09/02/24.
//

import UIKit

// MARK: Recently Generated Dogs Page
class RecentlyGeneratedViewController: UIViewController {

    // MARK: Properties
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 80
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var dogsImageCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    private lazy var clearButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Clear Dogs!", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .customBlue
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(clearImages), for: .touchUpInside)
        return btn
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dogsImageCollection.reloadData()
    }

    // MARK: Private Methods
    private func setUp() {
        title = "My Recently Generated Dogs!"
        view.backgroundColor = .systemBackground
        configureViews()
        configureConstraints()
        setUpCollectionView()
    }

    private func configureViews() {
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(dogsImageCollection)
        mainStack.addArrangedSubview(clearButton)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            dogsImageCollection.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/3),
            clearButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setUpCollectionView() {
        dogsImageCollection.dataSource = self
        dogsImageCollection.delegate = self
        dogsImageCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        if let layout = dogsImageCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 15
            layout.itemSize = CGSize(width: UIScreen.main.bounds.height / 3, height: UIScreen.main.bounds.height / 3)
        }
    }

    // MARK: Action Button
    @objc private func clearImages() {
        ImageDownloader.shared.clearCache()
        dogsImageCollection.showsHorizontalScrollIndicator = false
        dogsImageCollection.reloadData()
    }
}

