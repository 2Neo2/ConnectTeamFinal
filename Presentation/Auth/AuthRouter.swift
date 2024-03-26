//
//  AuthRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import UIKit


protocol AuthRouterProtocol {
    func openRegistrationFlow()
    func openTariffFlow(with token: String)
}

final class AuthRouter: AuthRouterProtocol {
    weak var view: AuthViewController?
    
    func openRegistrationFlow() {
        guard let view = view else { return }
        
        let destination = RegistrationConfigurator.configure()
        destination.modalPresentationStyle = .fullScreen
        view.present(destination, animated: true)
    }
    
    func openTariffFlow(with token: String) {
        guard let view = view else { return }
        
        let destination = TariffConfigurator.configure(with: token)
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
