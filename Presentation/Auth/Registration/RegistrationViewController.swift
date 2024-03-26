//
//  RegistrationViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import UIKit

final class RegistrationViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = Constants.Images.logo
        image.contentMode = .center
        return image
    }()
    
    private lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.textColor = Constants.Colors.textColor
        label.font = .boldSystemFont(ofSize: 23)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var logoVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, registrationLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 19.24
        
        return stackView
    }()
    
    private lazy var nameField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите Имя",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) ]
        )
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.setLeftPaddingPoints(16)
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        return textField
    }()
    
    private lazy var surnameField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите Фамилию",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) ]
        )
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.setLeftPaddingPoints(16)
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        return textField
    }()
    
    private lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) ]
        )
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.autocapitalizationType = .none
        textField.setLeftPaddingPoints(16)
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        return textField
    }()
    
    private lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Придумайте пароль",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) ]
        )
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.isSecureTextEntry = true
        textField.setLeftPaddingPoints(16)
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        
        return textField
    }()
    
    private lazy var passwordRepeatField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Повторите пароль",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) ]
        )
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.isSecureTextEntry = true
        textField.setLeftPaddingPoints(16)
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        
        return textField
    }()
    
    private lazy var fieldsVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameField, surnameField, emailField, passwordField, passwordRepeatField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30.0
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        
        button.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var signInButton: UIButton = {
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
        let attributedString = NSMutableAttributedString(string: "У вас есть аккаунт?  ", attributes: leftAttributes)
        attributedString.append(NSAttributedString(string: "Войти", attributes: rightAttributes))
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(signInButtontapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registrationButton, signInButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    var presenter: RegistrationPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        insertViews()
        layoutView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        [nameField, surnameField, emailField, passwordField, passwordRepeatField, signInButton].forEach {
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
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            logoVStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoVStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 107),
            
            fieldsVStackView.topAnchor.constraint(equalTo: logoVStackView.bottomAnchor, constant: 56),
            fieldsVStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            fieldsVStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            buttonsVStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            buttonsVStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            buttonsVStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -66.0),
            
            passwordField.heightAnchor.constraint(equalToConstant: 46),
            
            signInButton.heightAnchor.constraint(equalToConstant: 66),
            registrationButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    
    @objc private func registrationButtonTapped() {
        guard nameField.text?.isEmpty != true,
              surnameField.text?.isEmpty != true,
              emailField.text?.isEmpty != true,
              passwordField.text?.isEmpty != true,
              passwordRepeatField.text?.isEmpty != true
        else {
            SnackBar.make(in: self.view, message: "Заполните все поля!", duration: .lengthLong).show()
            return
        }
        if passwordField.text != passwordRepeatField.text {
            SnackBar.make(in: self.view, message: "Пароли не совпадают!", duration: .lengthLong).show()
            passwordField.text = ""
            passwordRepeatField.text = ""
            return
        }
        
        let regModel = UserRegistrationModel(
            name: nameField.text!,
            surname: surnameField.text!,
            email: emailField.text!,
            password: passwordField.text!
        )
        
        presenter?.openCofirmFlow(with: regModel)
    }
    
    @objc private func signInButtontapped() {
        presenter?.openSignInFlow()
    }
}

extension RegistrationViewController {
    func openEmptyFieldError() {
        
    }
}
