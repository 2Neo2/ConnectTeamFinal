//
//  UserDataViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import UIKit

final class UserDataViewController: UIViewController {
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
        label.text = "Личные данные"
        
        return label
    }()
    
    private lazy var accountIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus.circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var nameField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите имя",
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
            string: "Введите фамилию",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) ]
        )
        textField.layer.cornerRadius = 16
        textField.textColor = .white
        textField.setLeftPaddingPoints(16)
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        
        return textField
    }()
    
    private lazy var userInfoField: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.layer.cornerRadius = 16
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        textView.contentInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        textView.font = UIFont.systemFont(ofSize: 17)
        
        return textView
    }()
    
    private lazy var fieldsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            nameField, surnameField
        ])
        stack.axis = .vertical
        stack.spacing = 17.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        
        return stack
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
    
    var presenter: UserDataPresenter?
    
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
    
    @objc private func backButtonTapped() {
        presenter?.backButtonTapped()
    }
    
    @objc private func saveButtonTapped() {
        guard nameField.text?.isEmpty != true,
              surnameField.text?.isEmpty != true
        else {
            SnackBar.make(in: self.view, message: "Поля имени и фамилии не могут быть пустыми!", duration: .lengthShort).show()
            return
        }
        
        presenter?.changeUserData(nameField.text!, surnameField.text!, userInfoField.text!)
    }
    
    func showSomeError() {
        SnackBar.make(in: self.view, message: "Что-то пошло не так", duration: .lengthShort).show()
    }
}

extension UserDataViewController {
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        userInfoField.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        userInfoField.text = "Напишите что-нибуь о себе"
        userInfoField.delegate = self
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18.0),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            
            generalLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 11.0),
            generalLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            
            accountIconView.topAnchor.constraint(equalTo: generalLabel.bottomAnchor, constant: 38),
            accountIconView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            accountIconView.widthAnchor.constraint(equalToConstant: 120),
            accountIconView.heightAnchor.constraint(equalToConstant: 120),
            
            fieldsStackView.topAnchor.constraint(equalTo: accountIconView.bottomAnchor, constant: 28),
            fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            fieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -31.0),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            saveButton.heightAnchor.constraint(equalToConstant: 48.0),
            
            userInfoField.topAnchor.constraint(equalTo: fieldsStackView.bottomAnchor, constant: 17.0),
            userInfoField.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -150.0),
            userInfoField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            userInfoField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            
            nameField.heightAnchor.constraint(equalToConstant: 46.0)
        ])
    }
    
    private func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(generalLabel)
        view.addSubview(accountIconView)
        view.addSubview(fieldsStackView)
        view.addSubview(userInfoField)
        view.addSubview(saveButton)
    }
}

extension UserDataViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .white
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = "Напишите что-нибудь о себе"
        textView.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
    }
}

extension UserDataViewController {
    func updateProfileInfo(_ data: UserModel) {
        UIView.animate(withDuration: 0.3) {
            self.nameField.attributedPlaceholder = NSAttributedString(
                string: data.firstName,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) ]
            )
            self.surnameField.attributedPlaceholder = NSAttributedString(
                string: data.secondName,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) ]
            )
            
            if data.description != "" {
                self.userInfoField.text = data.description
            }
        }
    }
}
