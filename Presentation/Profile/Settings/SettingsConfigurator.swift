//
//  SettingsConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import UIKit

protocol SettingsConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class SettingsConfigurator: SettingsConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = SettingsViewController()
        let router = SettingsRouter()
        let presenter = SettingsPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        return view
    }
}
