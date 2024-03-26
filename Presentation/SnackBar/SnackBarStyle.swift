//
//  SnackBarStyle.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 11.02.2024.
//

import UIKit

public struct SnackBarStyle {
    public init() { }
    // Container
    public var background: UIColor = Constants.Colors.backgroundColor!
    var padding = 15
    var inViewPadding = 22
    // Label
    public var font: UIFont = .systemFont(ofSize: 17)
    var maxNumberOfLines: UInt = 2
}
