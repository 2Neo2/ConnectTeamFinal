//
//  RegistrationConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import UIKit

protocol RegistrationConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class RegistrationConfigurator: RegistrationConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = RegistrationViewController()
        let storage = AuthStorage()
        let service = AuthService()
        let presenter = RegistrationPresenter(authService: service, storage: storage)
        let router = RegistrationRouter()
        
        view.presenter = presenter
        router.view = view
        
        presenter.router = router
        presenter.view = view
        
        return view
    }
}
