//
//  AccountViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import UIKit

final class AccountViewController: UIViewController {
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
        label.text = "Аккаунт"
        return label
    }()
    
    private lazy var emailButton: ProfileButtonView = {
        let button = ProfileButtonView(text: "", image: nil, nil)
        button.frame = CGRect(x: 0, y: 0, width: view.frame.width - 45, height: 69)
        button.addTarget(self, action: #selector(changeEmailButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var changePassword: UIButton = {
        let button = ProfileButtonView(text: "Смена пароля", image: nil, nil)
        button.frame = CGRect(x: 0, y: 0, width: view.frame.width - 45, height: 69)
        button.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            emailButton, changePassword
        ])
        stack.axis = .vertical
        stack.spacing = 17.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = ProfileButtonView(text: "Выйти", image: Constants.Images.logoutImage, nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.cornerRadius = 16
        button.setTitleColor(.red, for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: AccountPresenter?
    
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
        
        [emailButton, changePassword]
            .forEach {
                $0.gradientBorder(
                    width: 1,
                    colors: [
                        UIColor(red: 0.163, green: 0.972, blue: 0.73, alpha: 1),
                        UIColor(red: 0.332, green: 0.777, blue: 0.968, alpha: 1)],
                    andRoundCornersWithRadius: 16
                )
            }
    }
    
    @objc private func backButtonTapped() {
        presenter?.backButtonTapped()
    }
    
    @objc private func logoutButtonTapped() {
        presenter?.logoutButtonTapped()
    }
    
    @objc private func changeEmailButtonTapped() {
        presenter?.openChangeEmailFlow()
    }
    
    @objc private func changePasswordButtonTapped() {
        presenter?.openChangePasswordFlow()
    }
}

extension AccountViewController {
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18.0),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            
            generalLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 11.0),
            generalLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            buttonsStackView.topAnchor.constraint(equalTo: generalLabel.bottomAnchor, constant: 39),
            
            logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22)
        ])
    }
    
    private func addSubviews() {
        view.addSubview(buttonsStackView)
        view.addSubview(logoutButton)
        view.addSubview(backButton)
        view.addSubview(generalLabel)
    }
}

extension AccountViewController {
    func updateProfileInfo(_ data: UserModel) {
        emailButton.setCustomTitile(with: data.email)
    }
}
