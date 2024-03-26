//
//  CustomGameNavigationBar.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 16.03.2024.
//

import UIKit

protocol CustomGameNavigationBarDelegate: AnyObject {
    func usersListButtonTapped()
}

final class CustomGameNavigationBar: UIView {
    private lazy var gameNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Название игры"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var userListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Constants.Images.bottomArrow, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(userListButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var separatorView = SeparatorView()
    
    weak var delegate: CustomGameNavigationBarDelegate?
    
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
    
    @objc private func userListButtonTapped() {
        delegate?.usersListButtonTapped()
    }
}

extension CustomGameNavigationBar {
    private func setupView() {
        backgroundColor = Constants.Colors.backgroundColor
        separatorView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            gameNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 19),
            gameNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15.0),
            
            userListButton.topAnchor.constraint(equalTo: topAnchor, constant: 19),
            userListButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.0),
            
            separatorView.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor, constant: 20.0),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    private func insertViews() {
        addSubview(gameNameLabel)
        addSubview(userListButton)
        addSubview(separatorView)
    }
}


