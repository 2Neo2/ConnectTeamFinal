//
//  AccountConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import UIKit

protocol AccountConfiguratorProtocol {
    static func configure(profileService: ProfileStorageUserModelService) -> UIViewController
}

final class AccountConfigurator: AccountConfiguratorProtocol {
    static func configure(profileService: ProfileStorageUserModelService) -> UIViewController {
        let view = AccountViewController()
        let presenter = AccountPresenter(profileService: profileService)
        let router = AccountRouter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        
        presenter.view = view
        
        return view
    }
}
