//
//  CompanyConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import UIKit

protocol CompanyConfiguratorProtocol {
    static func configure(profileService: ProfileStorageUserModelService) -> UIViewController
}

final class CompanyConfigurator: CompanyConfiguratorProtocol {
    static func configure(profileService: ProfileStorageUserModelService) -> UIViewController {
        let view = CompanyViewController()
        let router = CompanyRouter()
        let network = ProfileService()
        let presenter = CompanyPresenter(profileService: profileService, network: network)
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        
        presenter.view = view
        return view
    }
}
