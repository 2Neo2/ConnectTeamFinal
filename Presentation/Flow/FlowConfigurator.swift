//
//  FlowConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import UIKit

protocol FlowConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class FlowConfigurator: FlowConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = FlowViewController()
        let router = FlowRouter()
        
        let storage = AuthStorage()
        let profileService = ProfileService()
        
        let presenter = FlowPresenter(storage: storage, profileService: profileService)
        
        view.presenter = presenter
        router.view = view
        presenter.router = router
        presenter.view = view
        
        return view
    }
}
