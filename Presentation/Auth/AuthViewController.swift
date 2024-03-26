//
//  AuthViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import UIKit


protocol AuthViewControllerProtocol: AnyObject {
    func didAuthenticated()
}

final class AuthViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = Constants.Images.logo
        
        return image
    }()
    
    private lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.textColor = Constants.Colors.textColor
        label.font = .boldSystemFont(ofSize: 23)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var logoVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, signInLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 19.24
        
        return stackView
    }()
    
    private lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) ]
        )
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        textField.setLeftPaddingPoints(16)
        textField.autocapitalizationType = .none
        textField.textColor = .white
        return textField
    }()
    
    private lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите пароль",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) ]
        )
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        textField.isSecureTextEntry = true
        textField.setLeftPaddingPoints(16)
        textField.textColor = .white
        return textField
    }()
    
    private lazy var forgottenPassLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(
            string: "Забыли пароль?",
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue]
        )
        label.font = .systemFont(ofSize: 10.82)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        return label
    }()
    
    private lazy var fieldsVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailField, passwordField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30.0
        //stackView.contentMode = .scaleAspectFill
        return stackView
    }()
    
    private lazy var signInButton: UIButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
    
        let rightAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.34, green: 0.34, blue: 0.34, alpha: 1.00),
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
        ]
        let leftAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)
        ]
        let attributedString = NSMutableAttributedString(string: "Нет аккаунта? ", attributes: leftAttributes)
        attributedString.append(NSAttributedString(string: "Зарегистрироваться", attributes: rightAttributes))

        button.setAttributedTitle(attributedString, for: .normal)
        
        button.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signInButton, registrationButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 12
        return stackView
    }()
    
    var presenter: AuthPresenter?
    weak var delegate: AuthViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        insertViews()
        layoutView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        [emailField, passwordField, registrationButton].forEach {
//            $0.gradientBorder(
//                width: 1,
//                colors: [
//                    UIColor(red: 0.163, green: 0.972, blue: 0.73, alpha: 1),
//                    UIColor(red: 0.332, green: 0.777, blue: 0.968, alpha: 1)],
//                andRoundCornersWithRadius: 16
//            )
//        }
    }
    
    private func setupView() {
        view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    private func insertViews() {
        view.addSubview(logoVStackView)
        view.addSubview(fieldsVStackView)
        view.addSubview(buttonsVStackView)
        view.addSubview(forgottenPassLabel)
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            logoVStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoVStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 107),
            
            fieldsVStackView.topAnchor.constraint(equalTo: logoVStackView.bottomAnchor, constant: 187),
            fieldsVStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            fieldsVStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            forgottenPassLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            forgottenPassLabel.topAnchor.constraint(equalTo: fieldsVStackView.bottomAnchor, constant: 8),
            
            buttonsVStackView.topAnchor.constraint(equalTo: fieldsVStackView.bottomAnchor, constant: 135),
            buttonsVStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            buttonsVStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            //buttonsVStackView.heightAnchor.constraint(equalToConstant: 104),
            
            emailField.heightAnchor.constraint(equalToConstant: 42),
            passwordField.heightAnchor.constraint(equalToConstant: 42),
            signInButton.heightAnchor.constraint(equalToConstant: 48),
            registrationButton.heightAnchor.constraint(equalToConstant: 66)
        ])
    }
    
    @objc private func registrationButtonTapped() {
        presenter?.openRegistrationFlow()
    }
    
    @objc private func signInButtonTapped() {
        guard emailField.text?.isEmpty != true,
              passwordField.text?.isEmpty != true else {
                  SnackBar.make(in: self.view, message: "Заполните все поля!", duration: .lengthLong).show()
                  return
              }
        
        let model = UserAuthModel(email: emailField.text!, password: passwordField.text!)
        
        presenter?.openGameFlow(with: model)
    }
}

extension AuthViewController: AuthViewControllerProtocol {
    func didAuthenticated() {
        delegate?.didAuthenticated()
    }
}
