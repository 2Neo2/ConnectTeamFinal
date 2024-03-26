//
//  ProfileConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 11.01.2024.
//

import UIKit

protocol ProfileConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class ProfileConfigurator: ProfileConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = ProfileViewController()
        let authStorage = AuthStorage()
        let profileService = ProfileService()
        let profileStorage = ProfileStorageUserModelService(profileService: profileService, authStorage: authStorage)
        let presenter = ProfilePresenter(profileService: profileStorage)
        let router = ProfileRouter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        
        presenter.view = view
        
        return view
    }
}
 
