//
//  SettingsRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import Foundation

protocol SettingsRouterProtocol {
    func hideView()
}

final class SettingsRouter: SettingsRouterProtocol {
    weak var view: SettingsViewController?
    
    func hideView() {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
}
