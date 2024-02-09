//
//  GenerateImageViewController.swift
//  RandomDogGenerator
//
//  Created by Janvi Arora on 09/02/24.
//

import UIKit

// MARK: Generate Page
class GenerateImageViewController: UIViewController {

    // MARK: Properties
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 80
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .systemBackground
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var generateButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Generate!", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .customBlue
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(generate), for: .touchUpInside)
        return btn
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    // MARK: Private Methods
    private func setUp() {
        title = "Generate Dogs!"
        view.backgroundColor = .systemBackground
        configureViews()
        configureConstraints()
    }

    private func configureViews() {
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(imageView)
        mainStack.addArrangedSubview(generateButton)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/3),
            generateButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    // MARK: Action button
    @objc private func generate() {
        APICaller.shared.fetchRandomDog { result in
            switch result {
            case .success(let imageURL):
                if let url = URL(string: imageURL) {
                    ImageDownloader.shared.loadImageFromURL(url: url) { [weak self] image in
                        DispatchQueue.main.async {
                            self?.imageView.image = image
                        }
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
