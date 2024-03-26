//
//  CustomCreateGameView.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 09.03.2024.
//

import UIKit

protocol CreateGameProtocol: AnyObject {
    func createButtonTapped()
    func linkButtonTapped()
}

final class CustomCreateGameView: UIView, UITextFieldDelegate {
    private var createButtonTrailinghConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Создать игру"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var infoGameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите имя и фамилию",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) ]
        )
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        textField.setLeftPaddingPoints(16)
        textField.textColor = .white
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 16
        textField.delegate = self
        return textField
    }()
    
    private lazy var dateTextField: CustomTextFieldView = {
        let textView = CustomTextFieldView(image: Constants.Images.dateIcon!, constraint: 15, padding: UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 0))
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.attributedPlaceholder = NSAttributedString(
            string: "Введите дату XX/XX/XXXX",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)]
        )
        textView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        textView.delegate = self
        return textView
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите название игры",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) ]
        )
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        textField.setLeftPaddingPoints(16)
        textField.textColor = .white
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 16
        textField.delegate = self
        return textField
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Создать", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17.0)
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.25), for: .normal)
        button.backgroundColor = Constants.Colors.backgroundColor
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor =  UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
        button.isEnabled = false
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var linkButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Constants.Images.linkIcon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 16.0
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: CreateGameProtocol?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        insertViews()
        setupView()
        layoutView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        insertViews()
        setupView()
        layoutView()
    }
    
    @objc private func createButtonTapped() {
        delegate?.createButtonTapped()
        UIView.animate(withDuration: 0.5) {
            self.createButton.setTitle("Поделиться", for: .normal)
            self.createButtonTrailinghConstraint.constant = -84.0
            
            self.linkButton.isHidden = false
            
            // Обновление layout
            self.layoutIfNeeded()
        }
    }
    
    @objc private func linkButtonTapped() {
        delegate?.linkButtonTapped()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.updateSubmiUIState()
    }
    
    private func updateSubmiUIState() {
        let areAllTextFieldsFilled = infoGameTextField.hasText && dateTextField.hasText && nameTextField.hasText
        
        UIView.animate(withDuration: 0.5) {
            self.createButton.isEnabled = areAllTextFieldsFilled ? true : false
            if areAllTextFieldsFilled {
                self.configureGradientButton()
            } else {
                self.configureSimpleButton()
            }
        }
    }
    
    private func configureGradientButton() {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Создать", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17.0)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        
        self.createButton.removeFromSuperview()
        self.createButton = button
        
        self.addSubview(self.createButton)
        self.setupButton()
    }
    
    private func configureSimpleButton() {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Создать", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17.0)
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.25), for: .normal)
        button.backgroundColor = Constants.Colors.backgroundColor
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor =  UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
        button.isEnabled = false
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        
        self.createButton.removeFromSuperview()
        self.createButton = button
        
        self.addSubview(self.createButton)
        self.setupButton()
    }
    
    private func setupButton() {
        createButtonTrailinghConstraint = self.createButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23.0)
        NSLayoutConstraint.activate([
            self.createButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23.0),
            createButtonTrailinghConstraint,
            self.createButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20.0),
            self.createButton.heightAnchor.constraint(equalToConstant: 48.0),
        ])
    }
}

extension CustomCreateGameView {
    private func setupView() {
        backgroundColor = Constants.Colors.backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        infoGameTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
    }
    
    private func layoutView() {
        createButtonTrailinghConstraint = self.createButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23.0)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23.0),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18.0),
            
            infoGameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            infoGameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 23.0),
            infoGameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            infoGameTextField.heightAnchor.constraint(equalToConstant: 36),
            
            dateTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateTextField.topAnchor.constraint(equalTo: infoGameTextField.bottomAnchor, constant: 35.0),
            dateTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateTextField.heightAnchor.constraint(equalToConstant: 36),
            
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 35.0),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 36),
            
            createButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23.0),
            createButtonTrailinghConstraint,
            createButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20.0),
            createButton.heightAnchor.constraint(equalToConstant: 48.0),
            
            linkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23.0),
            linkButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20.0),
            linkButton.heightAnchor.constraint(equalToConstant: 48.0),
            linkButton.widthAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    private func insertViews() {
        addSubview(titleLabel)
        addSubview(infoGameTextField)
        addSubview(dateTextField)
        addSubview(nameTextField)
        addSubview(createButton)
        addSubview(linkButton)
    }
}
