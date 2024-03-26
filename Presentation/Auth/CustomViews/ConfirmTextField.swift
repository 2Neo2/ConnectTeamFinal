//
//  ConfirmTextField.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 25.01.2024.
//

import UIKit


final class SingleDigitField: UITextField {
    var pressedDelete = false
    
    override func willMove(toSuperview newSuperview: UIView?) {
        keyboardType = .numberPad
        textAlignment = .center
        backgroundColor = Constants.Colors.backgroundColor
        isSecureTextEntry = false
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect { .zero }
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] { [] }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool { false }
    
    override func deleteBackward() {
        pressedDelete = true
        sendActions(for: .editingChanged)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 16
        textColor = .white
        tintColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 42)
        ])
    }
}
