//
//  PasswordChangeConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 29.01.2024.
//

import UIKit

protocol PasswordChangeConfiguratorProtocol {
    static func configure(profileService: ProfileStorageUserModelService) -> UIViewController
}

final class PasswordChangeConfigurator: EmailChangeConfiguratorProtocol {
    static func configure(profileService: ProfileStorageUserModelService) -> UIViewController {
        let view = PasswordChangeViewController()
        let network = ProfileService()
        let presenter = PasswordChangePresenter(profileService: profileService, network: network)
        let router = PasswordChangeRouter()
        
        view.presenter = presenter
        router.view = view
        
        presenter.router = router
        
        presenter.view = view
        
        return view
    }
}
