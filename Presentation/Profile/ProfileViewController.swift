//
//  ProfileViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 11.01.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var accountIconView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(systemName: "person.crop.circle.fill")
        icon.tintColor = .gray
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    private lazy var accountButton: ProfileButtonView = {
        let button = ProfileButtonView(text: "Аккаунт", image: nil, nil)
        button.frame = CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 69)
        button.addTarget(self, action: #selector(accountButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var userInfoDataButton: ProfileButtonView = {
        let button = ProfileButtonView(text: "Личные данные", image: nil, nil)
        button.frame = CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 69)
        button.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var accessButton: ProfileButtonView = {
        let button = ProfileButtonView(text: "Доступ", image: nil, nil)
        button.frame = CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 69)
        button.addTarget(self, action: #selector(accessButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var companyButton: ProfileButtonView = {
        let button = ProfileButtonView(text: "Компания", image: nil, nil)
        button.frame = CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 69)
        button.addTarget(self, action: #selector(companyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var additionalSettingsButton: ProfileButtonView = {
        let button = ProfileButtonView(text: "Расширенные настройки", image: nil, nil)
        button.frame = CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 69)
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            accountButton, userInfoDataButton, accessButton, companyButton, additionalSettingsButton
        ])
        stack.axis = .vertical
        stack.spacing = 14.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    var presenter: ProfilePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addSubviews()
        layoutViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.updateDataOnView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [accountButton, userInfoDataButton, accessButton, companyButton, additionalSettingsButton].forEach {
            $0.gradientBorder(
                width: 1,
                colors: [
                    UIColor(red: 0.163, green: 0.972, blue: 0.73, alpha: 1),
                    UIColor(red: 0.332, green: 0.777, blue: 0.968, alpha: 1)],
                andRoundCornersWithRadius: 16
            )
        }
    }
    
    @objc private func accountButtonTapped() {
        presenter?.openAccountFlow()
    }
    
    @objc private func infoButtonTapped() {
        presenter?.openInfoUserDataFlow()
    }
    
    @objc private func accessButtonTapped() {
        presenter?.openAccessFlow()
    }
    
    @objc private func companyButtonTapped() {
        presenter?.openCompanyFlow()
    }
    
    @objc private func settingsButtonTapped() {
        presenter?.openSettingsFlow()
    }
}


extension ProfileViewController {
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        presenter?.updateDataOnView()
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            accountIconView.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            accountIconView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            accountIconView.widthAnchor.constraint(equalToConstant: 120),
            accountIconView.heightAnchor.constraint(equalToConstant: 120),
            
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.topAnchor.constraint(equalTo: accountIconView.bottomAnchor, constant: 7.0),
            usernameLabel.bottomAnchor.constraint(equalTo: accountIconView.bottomAnchor, constant: 38.0),
            
            buttonsStackView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 39.0),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 401.0)
        ])
    }
    
    private func addSubviews() {
        view.addSubview(accountIconView)
        view.addSubview(usernameLabel)
        view.addSubview(buttonsStackView)
    }
}

extension ProfileViewController {
    func updateProfileInfo(_ data: UserModel) {
        usernameLabel.text = "\(data.firstName) \(data.secondName)"
    }
}
