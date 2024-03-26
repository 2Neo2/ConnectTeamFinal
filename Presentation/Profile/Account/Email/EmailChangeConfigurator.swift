//
//  EmailChangeConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 29.01.2024.
//

import UIKit

protocol EmailChangeConfiguratorProtocol {
    static func configure(profileService: ProfileStorageUserModelService) -> UIViewController
}

final class EmailChangeConfigurator: EmailChangeConfiguratorProtocol {
    static func configure(profileService: ProfileStorageUserModelService) -> UIViewController {
        let view = EmailChangeViewController()
        let presenter = EmailChangePresenter()
        let router = EmailChangeRouter()
        
        view.presenter = presenter
        router.view = view
        
        presenter.router = router
        
        return view
    }
}
