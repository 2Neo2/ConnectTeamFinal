//
//  EmailChangeViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 29.01.2024.
//

import UIKit

final class EmailChangeViewController: UIViewController {
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
        label.text = "Смена почты"
        return label
    }()
    
    private lazy var newEmailField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите новую почту",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) ]
        )
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.setLeftPaddingPoints(16)
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        return textField
    }()
    
    private lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите пароль",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) ]
        )
        textField.layer.cornerRadius = 16
        textField.textColor = .white
        textField.setLeftPaddingPoints(16)
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        return textField
    }()
    
    private lazy var fieldsVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newEmailField, passwordField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30.0
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var iconLogo: UIImageView = {
        let image = UIImageView()
        image.image = Constants.Images.blurLogo
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    var presenter: EmailChangePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addViews()
        layoutView()
    }
    
    @objc private func backButtonTapped() {
        presenter?.hideView()
    }
    
    @objc private func saveButtonTapped() {
        
    }
}

extension EmailChangeViewController {
    private func setupView() {
        view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    private func addViews() {
        view.addSubview(backButton)
        view.addSubview(generalLabel)
        view.addSubview(iconLogo)
        view.addSubview(saveButton)
        view.addSubview(fieldsVStackView)
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18.0),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            
            generalLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 11.0),
            generalLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            
            fieldsVStackView.topAnchor.constraint(equalTo: generalLabel.bottomAnchor, constant: 34.0),
            fieldsVStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            fieldsVStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -31.0),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            saveButton.heightAnchor.constraint(equalToConstant: 48.0),
            
            iconLogo.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -81.0),
            iconLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10.0),
            
            newEmailField.heightAnchor.constraint(equalToConstant: 46.0)
        ])
    }
}
