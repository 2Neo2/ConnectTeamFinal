//
//  FilterViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 05.03.2024.
//

import UIKit

protocol FilterViewDelegate: AnyObject {
    func openGameList(with: FilterDataModel)
}

final class FilterViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Фильтры"
        label.font = .boldSystemFont(ofSize: 23)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "leftButtonArrow"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var playersNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Игроки"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var playersTextField: CustomTextFieldView = {
        let textView = CustomTextFieldView(image: Constants.Images.bottomArrow!, constraint: 21, padding: UIEdgeInsets(top: 24, left: 27, bottom: 23, right: 0))
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.attributedPlaceholder = NSAttributedString(
            string: "Введите имя игрока",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)]
        )
        return textView
    }()
    
    private lazy var gameNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Название игры"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var gameNameTextField: CustomTextFieldView = {
        let textView = CustomTextFieldView(image: Constants.Images.searchIcon!, constraint: 41, padding: UIEdgeInsets(top: 24, left: 27, bottom: 23, right: 0))
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.attributedPlaceholder = NSAttributedString(
            string: "Поиск по названию игры",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)]
        )
        return textView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Дата"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dateFromLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "от -"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dateFromTextField: CustomTextFieldView = {
        let textView = CustomTextFieldView(image: Constants.Images.dateIcon!, constraint: 16, padding: UIEdgeInsets(top: 13, left: 19, bottom: 13, right: 0))
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.attributedPlaceholder = NSAttributedString(
            string: "XX/XX/XXXX",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)]
        )
        return textView
    }()
    
    private lazy var dateToLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "до -"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dateToTextField: CustomTextFieldView = {
        let textView = CustomTextFieldView(image: Constants.Images.dateIcon!, constraint: 16, padding: UIEdgeInsets(top: 13, left: 19, bottom: 13, right: 0))
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.attributedPlaceholder = NSAttributedString(
            string: "XX/XX/XXXX",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)]
        )
        return textView
    }()
    
    private lazy var filterButton: GradientButton = {
        let button = GradientButton()
        button.setTitle("Применить фильтры", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: FilterPresenter?
    
    weak var delegate: FilterViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupView()
        layoutView()
    }
    
    @objc private func backButtonTapped() {
        presenter?.hideView()
    }
    
    @objc private func filterButtonTapped() {
        guard playersTextField.text?.isEmpty != true,
              gameNameTextField.text?.isEmpty != true,
              dateFromTextField.text?.isEmpty != true,
              dateToTextField.text?.isEmpty != true else {
            SnackBar.make(in: self.view, message: "Заполните все поля!", duration: .lengthLong).show()
            return
        }
        
        let model = FilterDataModel(
            playerName: playersTextField.text!,
            gameName: gameNameTextField.text!,
            dateFrom: dateFromTextField.text!,
            dateTo: dateToTextField.text!)
        
        delegate?.openGameList(with: model)
        presenter?.hideView()
    }
}

extension FilterViewController {
    private func setupView() {
        view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0),
            
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 4.0),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 58.0),
            
            playersNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 34.0),
            playersNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            
            playersTextField.topAnchor.constraint(equalTo: playersNameLabel.bottomAnchor, constant: 18.0),
            playersTextField.heightAnchor.constraint(equalToConstant: 69.0),
            playersTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            playersTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            
            gameNameLabel.topAnchor.constraint(equalTo: playersTextField.bottomAnchor, constant: 16.0),
            gameNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            
            gameNameTextField.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor, constant: 12.0),
            gameNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            gameNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            gameNameTextField.heightAnchor.constraint(equalToConstant: 69.0),
            
            dateLabel.topAnchor.constraint(equalTo: gameNameTextField.bottomAnchor, constant: 20.0),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            
            dateFromLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23.0),
            dateFromLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15.0),
            
            dateFromTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10.0),
            dateFromTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 106.0),
            dateFromTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            dateFromTextField.heightAnchor.constraint(equalToConstant: 48.0),
            
            dateToLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23.0),
            dateToLabel.topAnchor.constraint(equalTo: dateFromLabel.bottomAnchor, constant: 42.0),
            
            dateToTextField.topAnchor.constraint(equalTo: dateFromTextField.bottomAnchor, constant: 16.0),
            dateToTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 106.0),
            dateToTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            dateToTextField.heightAnchor.constraint(equalToConstant: 48.0),
            
            filterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -31.0),
            filterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            filterButton.heightAnchor.constraint(equalToConstant: 48.0),
        ])
    }
    
    private func insertViews() {
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(playersNameLabel)
        view.addSubview(playersTextField)
        view.addSubview(gameNameLabel)
        view.addSubview(gameNameTextField)
        view.addSubview(dateLabel)
        view.addSubview(dateFromLabel)
        view.addSubview(dateFromTextField)
        view.addSubview(dateToLabel)
        view.addSubview(dateToTextField)
        view.addSubview(filterButton)
    }
}
