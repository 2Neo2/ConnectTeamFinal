//
//  File.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 23.01.2024.
//

import UIKit

final class GamePlayViewController: UIViewController {
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "leftButtonArrow"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var customGameView = CustomCreateGameView()
    
    var presenter: GamePlayPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.backgroundColor
        setupView()
        insertViews()
        layoutViews()
    }
    
    @objc private func backButtonTapped() {
        customGameView.removeFromSuperview()
        self.backButton.isHidden = true
        self.customGameView = CustomCreateGameView()
        view.addSubview(self.customGameView)
        
        NSLayoutConstraint.activate([
            customGameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            customGameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            customGameView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 15.0),
            customGameView.heightAnchor.constraint(equalToConstant: 346.0)
        ])
    }
}

extension GamePlayViewController {
    private func setupView() {
        view.backgroundColor = Constants.Colors.backgroundColor
        customGameView.delegate = self
    }
    
    private func insertViews() {
        view.addSubview(backButton)
        view.addSubview(customGameView)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            
            customGameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            customGameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            customGameView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 15.0),
            customGameView.heightAnchor.constraint(equalToConstant: 346.0)
        ])
    }
}


extension GamePlayViewController: CreateGameProtocol {
    func createButtonTapped() {
        self.backButton.isHidden = false
        // TODO: create request To CreateGame.
    }
    
    func linkButtonTapped() {
        print("link")
    }
}

