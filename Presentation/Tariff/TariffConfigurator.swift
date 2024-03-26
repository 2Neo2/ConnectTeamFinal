//
//  TariffConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 18.02.2024.
//

import UIKit

protocol TariffConfiguratorProtocol {
    static func configure(with token: String) -> UIViewController
}

final class TariffConfigurator: TariffConfiguratorProtocol {
    static func configure(with token: String) -> UIViewController {
        let view = TariffViewController()
        let router = TariffRouter()
        let network = ProfileService()
        let presenter = TariffPresenter(network: network, token: token)
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        return view
    }
}
