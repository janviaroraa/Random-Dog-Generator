//
//  HomeViewController.swift
//  RandomDogGenerator
//
//  Created by Janvi Arora on 09/02/24.
//

import UIKit

// MARK: Home Page
class HomeViewController: UIViewController {

    // MARK: Properties
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var spacer: UIView = {
        let tempView = UIView()
        tempView.translatesAutoresizingMaskIntoConstraints = false
        return tempView
    }()

    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var appLabel: UILabel = {
        let label = UILabel()
        label.text = "Random Dog Generator!"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var generateImageButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Generate Dogs!", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .customBlue
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(generateImage), for: .touchUpInside)
        return btn
    }()

    private lazy var recentlyGeneratedButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("My Recently Generated Dogs!", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .customBlue
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(recentlyGenerated), for: .touchUpInside)
        return btn
    }()

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    // MARK: Private Methods
    private func setUp() {
        view.backgroundColor = .systemBackground
        configureViews()
        configureConstraints()
    }

    private func configureViews() {
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(appLabel)
        mainStack.addArrangedSubview(spacer)
        mainStack.addArrangedSubview(buttonsStack)
        buttonsStack.addArrangedSubview(generateImageButton)
        buttonsStack.addArrangedSubview(recentlyGeneratedButton)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            spacer.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/5),
            buttonsStack.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor),

            generateImageButton.heightAnchor.constraint(equalToConstant: 40),
            recentlyGeneratedButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    // MARK: Button Actions
    @objc private func generateImage() {
        let viewController = GenerateImageViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc private func recentlyGenerated() {
        let viewController = RecentlyGeneratedViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

}

