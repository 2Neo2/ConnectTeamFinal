//
//  QuestionViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 15.03.2024.
//

import UIKit

final class QuestionViewController: UIViewController {
    private lazy var customGameNavBar = CustomGameNavigationBar()
    
    private lazy var topicTheme: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Другая красивая длинная тема"
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var questionButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Вопрос для игрока 1", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(questionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: QuestionPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.backgroundColor
        setupView()
        insertViews()
        layoutViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @objc private func questionButtonTapped() {
        presenter?.openPlayFlow()
    }
}

extension QuestionViewController {
    private func setupView() {
        view.backgroundColor = Constants.Colors.backgroundColor
        customGameNavBar.translatesAutoresizingMaskIntoConstraints = false
        customGameNavBar.delegate = self
    }
    
    private func insertViews() {
        view.addSubview(customGameNavBar)
        view.addSubview(topicTheme)
        view.addSubview(questionButton)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            customGameNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customGameNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customGameNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 19.0),
            customGameNavBar.heightAnchor.constraint(equalToConstant: 59.0),
            
            topicTheme.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            topicTheme.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            topicTheme.topAnchor.constraint(equalTo: customGameNavBar.bottomAnchor, constant: 212.0),
            
            questionButton.topAnchor.constraint(equalTo: topicTheme.bottomAnchor, constant: 36.0),
            questionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            questionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            questionButton.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
}

extension QuestionViewController: CustomGameNavigationBarDelegate {
    func usersListButtonTapped() {
        print("keke")
    }
}
