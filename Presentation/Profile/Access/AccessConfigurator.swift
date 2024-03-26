//
//  AccessConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import UIKit

protocol AccessConfiguratorProtocol {
    static func configure(profileService service: ProfileStorageUserModelService) -> UIViewController
}

final class AccessConfigurator: AccessConfiguratorProtocol {
    static func configure(profileService service: ProfileStorageUserModelService) -> UIViewController {
        let view = AccessViewController()
        let router = AccessRouter()
        let network = ProfileService()
        let presenter = AccessPresenter(profileService: service, service: network)
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        
        presenter.view = view
        return view
    }
}
