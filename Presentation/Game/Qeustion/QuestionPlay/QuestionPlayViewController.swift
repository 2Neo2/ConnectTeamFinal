//
//  QuestionPlayViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 15.03.2024.
//

import UIKit

final class QuestionPlayViewController: UIViewController {
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
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Хорошо придуманный красивый вопрос о жизненном выборе ?"
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var endingAnswerButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Завершить ответ", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(endingAnswerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var gradientCircle = GradientCircleView()
    
    var presenter: QuestionPlayPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        insertViews()
        layoutViews()
    }
    
    @objc private func endingAnswerButtonTapped() {
        presenter?.openAnswerFlow()
    }
}

extension QuestionPlayViewController {
    private func setupView() {
        view.backgroundColor = Constants.Colors.backgroundColor
        customGameNavBar.translatesAutoresizingMaskIntoConstraints = false
        customGameNavBar.delegate = self
        gradientCircle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func insertViews() {
        view.addSubview(customGameNavBar)
        view.addSubview(topicTheme)
        view.addSubview(questionLabel)
        view.addSubview(endingAnswerButton)
        view.addSubview(gradientCircle)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            customGameNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customGameNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customGameNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 19.0),
            customGameNavBar.heightAnchor.constraint(equalToConstant: 59.0),
            
            topicTheme.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            topicTheme.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            topicTheme.topAnchor.constraint(equalTo: customGameNavBar.bottomAnchor, constant: 108.0),
            
            questionLabel.topAnchor.constraint(equalTo: topicTheme.bottomAnchor, constant: 50.0),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            
            gradientCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gradientCircle.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 150.0),
            gradientCircle.widthAnchor.constraint(equalToConstant: 120),
            gradientCircle.heightAnchor.constraint(equalToConstant: 120),
            
            endingAnswerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            endingAnswerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            endingAnswerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -66.0),
            endingAnswerButton.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }
}

extension QuestionPlayViewController: CustomGameNavigationBarDelegate {
    func usersListButtonTapped() {
        
    }
}
