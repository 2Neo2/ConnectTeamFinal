//
//  UserDataConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import UIKit

protocol UserDataConfiguratorProtocol {
    static func configure(profileService: ProfileStorageUserModelService) -> UIViewController
}

final class UserDataConfigurator: UserDataConfiguratorProtocol {
    static func configure(profileService: ProfileStorageUserModelService) -> UIViewController {
        let view = UserDataViewController()
        let router = UserDataRouter()
        let network = ProfileService()
        let presenter = UserDataPresenter(profileService: profileService, network: network)
        
        router.view = view
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        return view
    }
}
