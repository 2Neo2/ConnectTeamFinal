//
//  TariffViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.02.2024.
//

import UIKit

final class TariffViewController: UIViewController {
    var presenter: TariffPresenter?
    private var tariffs = [
        TariffViewModel(title: "Простой", subTitle: "Попробуйте бесплатный доступ на 14 дней!", rows:
                            [
                                "Возможность создания игры",
                                "Наличие трех тем с вопросами",
                                "Не более 10 вопросов на каждую тему",
                                "Возможность добавлять в одну игру не более 4 игроков"
                            ]),
        TariffViewModel(title: "Расширенный", subTitle: nil, rows:
                            [
                                "Возможность создания игры",
                                "5 тем с вопросами",
                                "До 20 вопросов на каждую тему",
                                "Возможность приглашать в игру до 5 игроков",
                                "Возможность выбора темы для конкретной игры"
                            ]),
        TariffViewModel(title: "Широкий", subTitle: nil, rows:
                            [
                                "Возможность создания игры",
                                "Возможность добавления авторизироанных пользователей сервиса в качестве дополнительных организаторов игр (до 3-х человек). Пользователь-владелец, купивший пакет, может управлять списком организаторов",
                                "10 тем с вопросами",
                                "До 50 вопросов на каждую тему",
                                "Возможность выбора темы для конкртеной игры"
                            ])
    ]
    private var currentTarif: TariffViewModel?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.separatorColor = .clear
        tableView.backgroundColor = Constants.Colors.backgroundColor
        return tableView
    }()
    
    private lazy var selectButton: UIButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Выбрать", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var withoutTariffButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let stringAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.34, green: 0.34, blue: 0.34, alpha: 1.00),
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
        ]
        let attributedString = NSMutableAttributedString(string: "Продолжить без тарифа", attributes: stringAttributes)

        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(withoutTariffButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertSubviews()
        setupView()
        layoutView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.register(TariffCell.self, forCellReuseIdentifier: TariffCell.reuseIdentifier)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: selectButton.topAnchor, constant: -10)
        ])
    }
    
    @objc private func selectButtonTapped() {
        guard let currentTarif = currentTarif else  {
            SnackBar.make(in: self.view, message: "Выберите тариф!", duration: .lengthShort).show()
            return
        }
        
        presenter?.openSelectedTariff(with: currentTarif)
    }
    
    @objc private func withoutTariffButtonTapped() {
        presenter?.openGameFlow()
    }
}

extension TariffViewController {
    private func setupView() {
        view.backgroundColor = Constants.Colors.backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            selectButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            selectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13),
            selectButton.heightAnchor.constraint(equalToConstant: 48.0),
            
            
            withoutTariffButton.topAnchor.constraint(equalTo: selectButton.bottomAnchor, constant: 7),
            withoutTariffButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            withoutTariffButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13)
        ])
    }
    
    private func insertSubviews() {
        view.addSubview(selectButton)
        view.addSubview(withoutTariffButton)
    }
}

extension TariffViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tariffs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TariffCell.reuseIdentifier, for: indexPath)
        
        guard let tariffCell = cell as? TariffCell else {
            return UITableViewCell()
        }
        
        let data = tariffs[indexPath.row]
        tariffCell.configureCell(with: data)
        tariffCell.selectionStyle = .none
        return tariffCell
    }
}

extension TariffViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTariff = tariffs[indexPath.row]
        currentTarif = selectedTariff
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
    }
}
