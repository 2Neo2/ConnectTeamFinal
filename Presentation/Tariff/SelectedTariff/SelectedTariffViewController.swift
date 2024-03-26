//
//  SelectedTariffViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 20.02.2024.
//

import UIKit

final class SelectedTariffViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = Constants.Images.logo
        image.contentMode = .center
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 26)
        label.textColor = .white
        return label
    }()
    
    private lazy var infoLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 19)
        return label
    }()
    
    private lazy var iconLogo: UIImageView = {
        let image = UIImageView()
        image.image = Constants.Images.blurLogo?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var buyButton: UIButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Купить", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.4) , for: .normal)
        button.setTitle("Отмена", for: .normal)
        button.backgroundColor = Constants.Colors.backgroundColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 16
        button.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: SelectedTariffPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertViews()
        setupView()
        layoutView()
        presenter?.updateDataOnView()
    }
    
    @objc private func buyButtonTapped() {
        presenter?.buyTariff()
    }
    
    @objc private func cancelButtonTapped() {
        presenter?.backButtonTapped()
    }
}

extension SelectedTariffViewController {
    private func setupView() {
        view.backgroundColor = Constants.Colors.backgroundColor
        infoLabel.paddingLeft = 42
        infoLabel.paddingTop = 24
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 107),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 48),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0),
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 23),
            
            buyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -127),
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            buyButton.heightAnchor.constraint(equalToConstant: 48.0),
            
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            cancelButton.topAnchor.constraint(equalTo: buyButton.bottomAnchor, constant: 20),
            cancelButton.heightAnchor.constraint(equalToConstant: 48.0),
            
            iconLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 75),
            iconLogo.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 35)
        ])
    }
    
    private func insertViews() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        view.addSubview(buyButton)
        view.addSubview(cancelButton)
        view.addSubview(iconLogo)
    }
}

extension SelectedTariffViewController {
    func updateLabels(with model: TariffViewModel) {
        titleLabel.text = model.title
        infoLabel.attributedText = NSAttributedStringHelper.createBulletedList(fromStringArray: model.rows)
    }
}
