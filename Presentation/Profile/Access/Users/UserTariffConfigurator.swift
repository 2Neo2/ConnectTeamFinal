//
//  UserTariffConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 26.03.2024.
//

import UIKit

protocol UserTariffConfiguratorProtocol {
    static func configure(profileService service: ProfileStorageUserModelService) -> UIViewController
}

final class UserTariffConfigurator: UserTariffConfiguratorProtocol {
    static func configure(profileService service: ProfileStorageUserModelService) -> UIViewController {
        let view = UserTariffViewController()
        let router = UserTariffRouter()
        let network = ProfileService()
        let presenter = UserTariffPresenter(profileService: service, service: network)
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        
        presenter.view = view
        return view
    }
}
