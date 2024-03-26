//
//  SelectedTariffConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 20.02.2024.
//

import UIKit

protocol SelectedTariffConfiguratorProtocol {
    static func configure(with token: String, _ model: TariffViewModel) -> UIViewController
}

final class SelectedTariffConfigurator: SelectedTariffConfiguratorProtocol {
    static func configure(with token: String, _ model: TariffViewModel) -> UIViewController {
        let view = SelectedTariffViewController()
        let router = SelectedTariffRouter()
        let network = ProfileService()
        let presenter = SelectedTariffPresenter(network: network, token: token, model: model)
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
