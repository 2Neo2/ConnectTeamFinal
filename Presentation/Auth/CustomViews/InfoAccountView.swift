//
//  InfoAccountView.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import UIKit

final class InfoAccountView: UIView {
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var regButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 0
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
