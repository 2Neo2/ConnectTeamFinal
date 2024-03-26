//
//  CustomSeparatorView.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 13.03.2024.
//

import UIKit


final class SeparatorView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [
            UIColor(red: 0.163, green: 0.972, blue: 0.73, alpha: 1).cgColor,
            UIColor(red: 0.332, green: 0.777, blue: 0.968, alpha: 1).cgColor
        ]
        l.startPoint = CGPoint(x: 1, y: 0.5)
        l.endPoint = CGPoint(x: 0, y: 0.5)
        layer.insertSublayer(l, at: 0)
        return l
    }()
}

