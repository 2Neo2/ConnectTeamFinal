//
//  UserTariffViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 26.03.2024.
//

import UIKit

final class UserTariffViewController: UIViewController {
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "leftButtonArrow"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var generalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 23)
        label.textColor = .white
        label.text = "Участники тарифа"
        return label
    }()
    
    private lazy var addUserButton: UIButton = {
        let button = GradientButton()
        button.setTitle("Добавить участника", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addUserButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: UserTariffPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addSubviews()
        layoutViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // TODO: connect with server.
    }
    
    @objc
    private func backButtonTapped() {
        presenter?.backButtonTapped()
    }
    
    @objc
    private func addUserButtonTapped() {
        //presenter?.openTarifFlow()
    }
}

extension UserTariffViewController {
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18.0),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            
            generalLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 11.0),
            generalLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            
            addUserButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58),
            addUserButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addUserButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addUserButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    private func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(generalLabel)
        view.addSubview(addUserButton)
    }
}

extension UserTariffViewController {
    func updateDataOnView(_ data: TariffResult) {
        
    }
    
    func showSomeError() {
        
    }
}
