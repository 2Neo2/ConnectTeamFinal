//
//  ConfirmViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 25.01.2024.
//

import UIKit


final class ConfirmViewController: UIViewController {
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "leftButtonArrow"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = Constants.Images.logo
        image.contentMode = .center
        return image
    }()
    
    private lazy var confirmLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код"
        label.textColor = Constants.Colors.textColor
        label.font = .boldSystemFont(ofSize: 23)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var logoVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, confirmLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 19.24
        
        return stackView
    }()
    
    private lazy var firstDigitField: UITextField = {
        let field = SingleDigitField()
        field.isUserInteractionEnabled = true
        field.becomeFirstResponder()
        field.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        return field
    }()
    
    private lazy var secondDigitField: UITextField = {
        let field = SingleDigitField()
        field.isUserInteractionEnabled = false
        field.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        return field
    }()
    
    private lazy var thirdDigitField: UITextField = {
        let field = SingleDigitField()
        field.isUserInteractionEnabled = false
        field.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        return field
    }()
    
    private lazy var fourthDigitField: UITextField = {
        let field = SingleDigitField()
        field.isUserInteractionEnabled = false
        field.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        return field
    }()
    
    private lazy var fieldsHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstDigitField, secondDigitField, thirdDigitField, fourthDigitField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 17
        return stackView
    }()
    
    private lazy var repeatCodeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Отправить код повторно", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        
        return button
    }()
    
    var presenter: ConfirmPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addViews()
        layoutView()
        presenter?.loadCode()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        [firstDigitField, secondDigitField, thirdDigitField, fourthDigitField].forEach {
//            $0.gradientBorder(
//                width: 1,
//                colors: [
//                    UIColor(red: 0.163, green: 0.972, blue: 0.73, alpha: 1),
//                    UIColor(red: 0.332, green: 0.777, blue: 0.968, alpha: 1)],
//                andRoundCornersWithRadius: 16
//            )
//        }
        
        repeatCodeButton.titleLabel?.sizeToFit()
        let gradient = UIImage.gImage(frame: repeatCodeButton.bounds, colors: [
            UIColor(red: 0.163, green: 0.972, blue: 0.73, alpha: 1),
            UIColor(red: 0.332, green: 0.777, blue: 0.968, alpha: 1)
        ])
        repeatCodeButton.setTitleColor(UIColor.init(patternImage: gradient), for: .normal)
    }
    
    private func setupView() {
        view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    private func addViews() {
        view.addSubview(logoVStackView)
        view.addSubview(fieldsHStackView)
        view.addSubview(repeatCodeButton)
        view.addSubview(backButton)
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18.0),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.0),
            
            logoVStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoVStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 176),
            
            fieldsHStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fieldsHStackView.topAnchor.constraint(equalTo: logoVStackView.bottomAnchor, constant: 129),
            fieldsHStackView.widthAnchor.constraint(equalToConstant: 230),
            fieldsHStackView.heightAnchor.constraint(equalToConstant: 61),
            
            repeatCodeButton.topAnchor.constraint(equalTo: fieldsHStackView.bottomAnchor, constant: 68.0),
            repeatCodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            repeatCodeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            repeatCodeButton.heightAnchor.constraint(equalToConstant: 45.0)
        ])
    }
    
    func showSomeError() {
        SnackBar.make(in: self.view, message: "Некорректный код пользователя!", duration: .lengthLong).show()
        [firstDigitField, secondDigitField, thirdDigitField, fourthDigitField].forEach {
            $0.text = ""
        }
    }
    
    @objc private func backButtonTapped() {
        presenter?.backButtonTapped()
    }
    
    @objc private func signInButtonTapped() {
        var code = ""
        [firstDigitField, secondDigitField, thirdDigitField, fourthDigitField].forEach {
            code.append($0.text!)
        }
        presenter?.checkCofirmCode(with: code)
    }
    
    @objc func editingChanged(_ textField: SingleDigitField) {
        if textField.pressedDelete {
            textField.pressedDelete = false
            if textField.hasText {
                textField.text = ""
            } else {
                switch textField {
                case secondDigitField, thirdDigitField, fourthDigitField:
                    textField.resignFirstResponder()
                    textField.isUserInteractionEnabled = false
                    switch textField {
                    case secondDigitField:
                        firstDigitField.isUserInteractionEnabled = true
                        firstDigitField.becomeFirstResponder()
                        firstDigitField.text = ""
                    case thirdDigitField:
                        secondDigitField.isUserInteractionEnabled = true
                        secondDigitField.becomeFirstResponder()
                        secondDigitField.text = ""
                    case fourthDigitField:
                        thirdDigitField.isUserInteractionEnabled = true
                        thirdDigitField.becomeFirstResponder()
                        thirdDigitField.text = ""
                    default:
                        break
                    }
                default: break
                }
            }
        }

        guard textField.text?.count == 1, textField.text?.last?.isWholeNumber == true else {
            textField.text = ""
            return
        }
        
        switch textField {
        case firstDigitField, secondDigitField, thirdDigitField:
            textField.resignFirstResponder()
            textField.isUserInteractionEnabled = false
            switch textField {
            case firstDigitField:
                secondDigitField.isUserInteractionEnabled = true
                secondDigitField.becomeFirstResponder()
            case secondDigitField:
                thirdDigitField.isUserInteractionEnabled = true
                thirdDigitField.becomeFirstResponder()
            case thirdDigitField:
                fourthDigitField.isUserInteractionEnabled = true
                fourthDigitField.becomeFirstResponder()
            default: break
            }
        case fourthDigitField:
            var code = ""
            [firstDigitField, secondDigitField, thirdDigitField, fourthDigitField].forEach {
                code.append($0.text!)
            }
            presenter?.checkCofirmCode(with: code)
            fourthDigitField.becomeFirstResponder()
        default: break
        }
    }
    
}
