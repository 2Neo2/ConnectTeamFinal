//
//  GameListCell.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 09.03.2024.
//

import UIKit

final class GameListCell: UITableViewCell {
    static let reuseIdentifier = "GameListCell"
    
    private lazy var gameNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: .init(
            top: 9.0, left: .zero, bottom: 9.0, right: .zero
        ))
        
        layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        
        addGradientBorder(width: 1.0, colors: [
            UIColor(red: 0.163, green: 0.972, blue: 0.73, alpha: 1),
            UIColor(red: 0.332, green: 0.777, blue: 0.968, alpha: 1)
        ])
    }
    
    private func addGradientBorder(width: CGFloat, colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: self.contentView.bounds.height)
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        let shape = CAShapeLayer()
        shape.lineWidth = width
        shape.path = UIBezierPath(roundedRect: self.contentView.bounds.insetBy(dx: width / 2, dy: width / 2), cornerRadius: contentView.layer.cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradientLayer.mask = shape

        self.contentView.layer.addSublayer(gradientLayer)
    }

    private func setupView() {
        self.contentView.addSubview(gameNameLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(statusLabel)
        
        self.backgroundColor = Constants.Colors.backgroundColor
        
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 16
    }
    
    func configureCell(for model: GameDataModel) {
        self.gameNameLabel.text = model.gameName
        self.dateLabel.text = model.date
        self.statusLabel.text = model.status
        
        if model.status == "завершена" {
            self.statusLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        } else if model.status == "не начата" {
            self.statusLabel.textColor = .red
        } else {
            self.statusLabel.textColor = .gray
        }
        
        setupView()
        layoutView()

    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            gameNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 39.0),
            gameNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
            
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9.0),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25.0),
            
            statusLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 1.0),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21.0)
        ])
    }
}
