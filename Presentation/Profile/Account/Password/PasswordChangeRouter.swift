//
//  PasswordChangeRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 29.01.2024.
//

import Foundation

protocol PasswordChangeRouterProtocol {
    func hideView()
}

final class PasswordChangeRouter: PasswordChangeRouterProtocol {
    weak var view: PasswordChangeViewController?
    
    func hideView() {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
}
