//
//  TariffCell.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.02.2024.
//

import UIKit

final class TariffCell: UITableViewCell {
    static let reuseIdentifier = "TariffListCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 23.0)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16.0)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonResize: UIButton = {
        let button = UIButton()
        button.setImage(Constants.Images.resizeViewButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var iconLogo: UIImageView = {
        let image = UIImageView()
        image.image = Constants.Images.blurLogo
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
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
        
        contentView.frame = contentView.frame.inset(by: .init(
            top: 11.0, left: .zero, bottom: 11.0, right: .zero
        ))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        insertViews()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with model: TariffViewModel) {
        infoLabel.attributedText = NSAttributedStringHelper.createBulletedList(fromStringArray: model.rows)
        infoLabel.numberOfLines = 0
        titleLabel.text = model.title
        
        setupView()
        insertViews()
        layoutView()
    }
    
}

extension TariffCell {
    private func setupView() {
        backgroundColor = Constants.Colors.backgroundColor
        self.contentView.layer.cornerRadius = 16
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.white.cgColor
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
            
            buttonResize.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonResize.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            
            iconLogo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            iconLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 200)
        ])
    }
    
    private func insertViews() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(buttonResize)
        self.contentView.addSubview(infoLabel)
        self.contentView.addSubview(iconLogo)
        self.contentView.addSubview(subtitleLabel)
    }
}
