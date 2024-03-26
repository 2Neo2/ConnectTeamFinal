//
//  ProfileButtonView.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import UIKit

final class ProfileButtonView: UIButton {
    private struct ProfileConstants {
        static let trailingConstraint = -15.0
        static let topConstraint = 23.0
        static let leadingConstraint = 25.0
        static let bottomConstraint = -22.0
        static let iconArrow = UIImage(named: "rightButtonArrow")
        static let buttonWidth = 335.0
        static let buttonHeight = 69.0
    }
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = ProfileConstants.iconArrow?.withRenderingMode(.alwaysTemplate)
        return icon
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        return label
    }()
    
    init(text labelText: String, image rightImage: UIImage?, _ placeholder: String?) {
        super.init(frame: .zero)
        infoLabel.text = labelText
        if labelText == "Выйти" {
            infoLabel.textColor = .red
        } else {
            infoLabel.textColor = .white
        }
        if let rightImage = rightImage {
            iconView.image = rightImage
        } else {
            iconView.image = Constants.Images.rightArrow
        }
        
        if let placeholder = placeholder {
            placeholderLabel.text = placeholder
        }
        
        setupView()
        addSubviews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileButtonView {
    private func setupView() {
        backgroundColor = Constants.Colors.backgroundColor
    }
    
    private func addSubviews() {
        addSubview(infoLabel)
        addSubview(iconView)
        addSubview(placeholderLabel)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ProfileConstants.leadingConstraint),
            infoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: ProfileConstants.topConstraint),
            infoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ProfileConstants.bottomConstraint),
            
            iconView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ProfileConstants.trailingConstraint),
            iconView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ProfileConstants.bottomConstraint),
            iconView.topAnchor.constraint(equalTo: self.topAnchor, constant: ProfileConstants.topConstraint),
            
            placeholderLabel.trailingAnchor.constraint(equalTo: iconView.leadingAnchor, constant: -7),
            placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            placeholderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -23)
        ])
    }
    
    func setCustomTitile(with label: String) {
        infoLabel.text = label
    }
}
