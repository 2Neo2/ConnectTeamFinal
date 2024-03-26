//
//  CustomAccessView.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 23.03.2024.
//

import UIKit

final class CustomAccessView: UIView {
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 23.0)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.font = .boldSystemFont(ofSize: 17.0)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        insertViews()
        setupView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValues(with model: TariffResult) {
        var index = -1
        switch model.planType {
        case "advanced":
            index = 1
        case "basic":
            index = 0
        case "premium":
            index = 2
        default:
            print("some error")
        }
        
        infoLabel.attributedText = NSAttributedStringHelper.createBulletedList(fromStringArray: tariffs[index].rows)
        infoLabel.numberOfLines = 0
        titleLabel.text = tariffs[index].title
    }
}

extension CustomAccessView {
    private func setupView() {
        backgroundColor = Constants.Colors.backgroundColor
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        infoLabel.paddingLeft = 42
        infoLabel.paddingBottom = -42
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 121),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -121),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 34),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
        ])
    }
    
    private func insertViews() {
        self.addSubview(titleLabel)
        self.addSubview(infoLabel)
    }
}
