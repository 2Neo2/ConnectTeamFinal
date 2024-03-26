//
//  AnswerViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 18.03.2024.
//

import UIKit

final class AnswerViewController: UIViewController {
    private lazy var customGameNavBar = CustomGameNavigationBar()
    
    private lazy var answerRatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Оценка ответов"
        label.font = .boldSystemFont(ofSize: 20.0)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var playerName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Игрок 1"
        label.font = .systemFont(ofSize: 30.0)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackHView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 11
        
        for _ in 0..<5 {
            let imageView = UIImageView(image: Constants.Images.starIcon)
            imageView.contentMode = .scaleAspectFit
            stack.addArrangedSubview(imageView)
        }
        
        return stack
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17.0)
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.25), for: .normal)
        button.backgroundColor = Constants.Colors.backgroundColor
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: AnswerPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        insertViews()
        layoutViews()
    }
    
    @objc private func continueButtonTapped() {
        presenter?.openAnswerFlow()
    }
}


extension AnswerViewController {
    private func setupView() {
        view.backgroundColor = Constants.Colors.backgroundColor
        customGameNavBar.translatesAutoresizingMaskIntoConstraints = false
        customGameNavBar.delegate = self
        
    }
    
    private func insertViews() {
        view.addSubview(customGameNavBar)
        view.addSubview(answerRatingLabel)
        view.addSubview(playerName)
        view.addSubview(stackHView)
        view.addSubview(continueButton)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            customGameNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customGameNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customGameNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 19.0),
            customGameNavBar.heightAnchor.constraint(equalToConstant: 59.0),
            
            answerRatingLabel.topAnchor.constraint(equalTo: customGameNavBar.bottomAnchor, constant: 106.0),
            answerRatingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 74.0),
            answerRatingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -74.0),
            
            playerName.topAnchor.constraint(equalTo: answerRatingLabel.bottomAnchor, constant: 73.0),
            playerName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 108.0),
            playerName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -108.0),
            
            stackHView.topAnchor.constraint(equalTo: playerName.bottomAnchor, constant: 43.0),
            stackHView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 71.0),
            stackHView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -71.0),
            stackHView.heightAnchor.constraint(equalToConstant: 37),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -66.0),
            continueButton.heightAnchor.constraint(equalToConstant: 48.0),
        ])
    }
}

extension AnswerViewController: CustomGameNavigationBarDelegate {
    func usersListButtonTapped() {
        
    }
}
