//
//  EmptyConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 22.02.2024.
//

import UIKit

protocol EmptyConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class EmptyConfigurator: EmptyConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = EmptyViewController()
        let service = AuthService()
        let profileService = ProfileService()
        let presenter = EmptyPresenter(service: service, profileService: profileService)
        let router = EmptyRouter()
        
        view.presenter = presenter
        router.view = view
        presenter.router = router
        
        return view
    }
}
