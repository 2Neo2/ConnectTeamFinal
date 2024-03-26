//
//  GradientCircleView.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 17.03.2024.
//

import UIKit

class GradientCircleView: UIView {
    private var gradientLayer: CAGradientLayer!
    private var shapeLayer: CAShapeLayer!
    private var timerLabel: UILabel!
    private var timer: Timer?
    private var remainingSeconds: Int = 180 {
        didSet {
            timerLabel.text = "\(remainingSeconds)"
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "секунд"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 19)
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(titleLabel)
        setupGradientLayer()
        setupTimerLabel()
        startTimer()
    }

    private func setupGradientLayer() {
        gradientLayer?.removeFromSuperlayer()
        shapeLayer?.removeFromSuperlayer()

        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 0.163, green: 0.972, blue: 0.73, alpha: 1).cgColor, UIColor(red: 0.332, green: 0.777, blue: 0.968, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = bounds

        let circularPath = UIBezierPath(ovalIn: bounds.insetBy(dx: 10, dy: 10)).cgPath

        shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 10
        shapeLayer.path = circularPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor

        gradientLayer.mask = shapeLayer

        layer.addSublayer(gradientLayer)
    }

    private func setupTimerLabel() {
        if timerLabel == nil {
            timerLabel = UILabel()
            timerLabel.textColor = .white
            timerLabel.translatesAutoresizingMaskIntoConstraints = false
            timerLabel.textAlignment = .center
            timerLabel.font = .systemFont(ofSize: 19)
            timerLabel.numberOfLines = 0
            addSubview(timerLabel)
            
            NSLayoutConstraint.activate([
                timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
                timerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
                timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 15),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            ])
        }
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
            } else {
                self.timer?.invalidate()
            }
        }
    }
}
