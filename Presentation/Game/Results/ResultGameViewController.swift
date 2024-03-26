//
//  ResultGameViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 26.03.2024.
//

import UIKit

final class ResultGameViewController: UIViewController {
    private lazy var customGameNavBar = CustomGameNavigationBar()
    
    private lazy var topicTheme: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Результат игры"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var presenter: QuestionPlayPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        insertViews()
        layoutViews()
    }
    
    @objc private func endingAnswerButtonTapped() {
        
    }
}

extension ResultGameViewController {
    private func setupView() {
        view.backgroundColor = Constants.Colors.backgroundColor
        customGameNavBar.translatesAutoresizingMaskIntoConstraints = false
        customGameNavBar.delegate = self
    }
    
    private func insertViews() {
        view.addSubview(customGameNavBar)
        view.addSubview(topicTheme)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            customGameNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customGameNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customGameNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5.0),
            customGameNavBar.heightAnchor.constraint(equalToConstant: 59.0),
            
            topicTheme.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            topicTheme.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            topicTheme.topAnchor.constraint(equalTo: customGameNavBar.bottomAnchor, constant: 108.0),
        ])
    }
}

extension ResultGameViewController: CustomGameNavigationBarDelegate {
    func usersListButtonTapped() {
        
    }
}
