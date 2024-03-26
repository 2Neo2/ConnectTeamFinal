//
//  EmptyViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 22.02.2024.
//

import UIKit

final class EmptyViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 26)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Эта функция доступна\nтолько для пользователей\nс активными тарифами"
        return label
    }()
    
    private lazy var selectTariffButton: UIButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Выбрать тариф", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(selectTariffButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: EmptyPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupViews()
        layoutViews()
    }
    
    @objc private func selectTariffButtonTapped() {
        presenter?.openTariffFlow()
    }
}

extension EmptyViewController {
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            selectTariffButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            selectTariffButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            selectTariffButton.heightAnchor.constraint(equalToConstant: 48.0),
            
            titleLabel.bottomAnchor.constraint(equalTo: selectTariffButton.topAnchor, constant: -30.0),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 39.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40.0),
        ])
    }
    
    private func insertViews() {
        view.addSubview(titleLabel)
        view.addSubview(selectTariffButton)
    }
}
