//
//  TariffRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 18.02.2024.
//

import UIKit

protocol TariffRouterProtocol {
    func hideView()
    func openSelectedTariff(with token: String, and model: TariffViewModel)
}

final class TariffRouter: TariffRouterProtocol {
    weak var view: TariffViewController?
    
    func hideView() {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
    
    func openSelectedTariff(with token: String, and model: TariffViewModel) {
        guard let view = view else { return }
        let destination = SelectedTariffConfigurator.configure(with: token, model)
        destination.modalPresentationStyle = .fullScreen
        view.present(destination, animated: true)
    }
    
    func openGameFlow() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid configuration!") }
        
        let tabBarController = CustomTabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
