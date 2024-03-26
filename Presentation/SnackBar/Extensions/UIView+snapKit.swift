//
//  UIView+snapKit.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 11.02.2024.
//

import UIKit
import SnapKit

extension UIView {
    func setupSubview(_ subview: UIView, setup: (ConstraintViewDSL) -> Void) {
        self.addSubview(subview)
        setup(subview.snp)
    }
}
