//
//  SettingsViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import UIKit

final class SettingsViewController: UIViewController {
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
        label.text = "Расширенные настройки"
        return label
    }()
    
    var presenter: SettingsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addSubviews()
        layoutViews()
    }
    
    @objc private func backButtonTapped() {
        presenter?.backButtonTapped()
    }
}

extension SettingsViewController {
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18.0),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            
            generalLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 11.0),
            generalLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0)
        ])
    }
    
    private func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(generalLabel)
    }
}
