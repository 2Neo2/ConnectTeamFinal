//
//  AuthConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import UIKit

protocol AuthConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class AuthConfigurator: AuthConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = AuthViewController()
        let service = AuthService()
        let profileService = ProfileService()
        let presenter = AuthPresenter(service: service, profileService: profileService)
        let router = AuthRouter()
        
        view.presenter = presenter
        router.view = view
        presenter.router = router
        presenter.view = view
        
        return view
    }
}
