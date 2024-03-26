//
//  CustomTextFieldView.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 06.03.2024.
//

import UIKit

final class CustomTextFieldView: UITextField {
    private var padding: UIEdgeInsets?
    
    private lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()

    init(image: UIImage, constraint rightConstraint: Int, padding: UIEdgeInsets) {
        super.init(frame: .zero)
        insertViews()
        setupView(image: image, padding: padding)
        if rightConstraint == 41 {
            layoutView(value: rightConstraint, topValue: 27)
        } else if rightConstraint == 16 {
            layoutView(value: rightConstraint, topValue: 16)
        } else if rightConstraint == 15 {
            layoutView(value: rightConstraint, topValue: 10)
        } else {
            layoutView(value: rightConstraint)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func insertViews() {
        addSubview(iconView)
    }

    private func setupView(image: UIImage, padding: UIEdgeInsets) {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 16
        textColor = .white
        self.padding = padding
        iconView.image = image
    }
    
    private func layoutView(value: Int, topValue: Int? = nil) {
        NSLayoutConstraint.activate([
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat(value)),
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(topValue ?? 23))
        ])
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding ?? UIEdgeInsets.zero)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding ?? UIEdgeInsets.zero)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

}
