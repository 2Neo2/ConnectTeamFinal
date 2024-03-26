//
//  AccessViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import UIKit

final class AccessViewController: UIViewController {
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
        label.text = "Доступ"
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.text = "Ваш тариф:"
        return label
    }()
    
    private lazy var accessView = CustomAccessView()
    
    private lazy var changeAccessButton: UIButton = {
        let button = GradientButton()
        button.setTitle("Сменить тариф", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeTariffButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        label.text = "Следующее списание: "
        label.textAlignment = .center
        return label
    }()
    
    private lazy var usersButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Участники тарифа", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17.0)
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.25), for: .normal)
        button.backgroundColor = Constants.Colors.backgroundColor
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor =  UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
        button.isHidden = true
        button.addTarget(self, action: #selector(usersButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: AccessPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addSubviews()
        layoutViews()
        
        presenter?.getMyPlan()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.getMyPlan()
    }
    
    @objc
    private func backButtonTapped() {
        presenter?.backButtonTapped()
    }
    
    @objc
    private func usersButtonTapped() {
        presenter?.openUserTariffFlow()
    }
    
    @objc
    private func changeTariffButtonTapped() {
        presenter?.openTarifFlow()
    }
}

extension AccessViewController {
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        accessView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18.0),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            
            generalLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 11.0),
            generalLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            infoLabel.topAnchor.constraint(equalTo: generalLabel.bottomAnchor, constant: 34),
            
            changeAccessButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58),
            changeAccessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            changeAccessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            changeAccessButton.heightAnchor.constraint(equalToConstant: 48),
            
            accessView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            accessView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            accessView.topAnchor.constraint(equalTo: infoLabel.topAnchor, constant: 33.0),
            accessView.heightAnchor.constraint(equalToConstant: 350.0),
            
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 66.0),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -66.0),
            dateLabel.topAnchor.constraint(equalTo: accessView.bottomAnchor, constant: 10.0),
            
            usersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            usersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            usersButton.heightAnchor.constraint(equalToConstant: 48),
            usersButton.bottomAnchor.constraint(equalTo: changeAccessButton.topAnchor, constant: -16.0)
        ])
    }
    
    private func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(generalLabel)
        view.addSubview(infoLabel)
        view.addSubview(changeAccessButton)
        view.addSubview(accessView)
        view.addSubview(dateLabel)
        view.addSubview(usersButton)
    }
}

extension AccessViewController {
    func updateProfileInfo(_ data: TariffResult) {
        if data.planType != "basic" {
            usersButton.isHidden = false
        }
        
        dateLabel.text = "Следующее списание: \(data.expiryDate)"
        accessView.setValues(with: data)
    }
    
    func showSomeError() {
        
    }
}
