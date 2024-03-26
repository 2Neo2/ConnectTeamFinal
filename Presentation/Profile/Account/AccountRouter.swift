//
//  AccountRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import UIKit

protocol AccountRouterProtocol {
    func hideView()
    func logout()
    func openEmailFlow(with service: ProfileStorageUserModelService)
    func openPasswordFlow(with service: ProfileStorageUserModelService)
}

final class AccountRouter: AccountRouterProtocol {
    weak var view: AccountViewController?
    
    func hideView() {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
    
    func openEmailFlow(with service: ProfileStorageUserModelService) {
        guard let view = view else { return }
        
        let destination = EmailChangeConfigurator.configure(profileService: service)
        destination.modalPresentationStyle = .fullScreen
        view.present(destination, animated: true)
    }
    
    func openPasswordFlow(with service: ProfileStorageUserModelService) {
        guard let view = view else { return }
        
        let destination = PasswordChangeConfigurator.configure(profileService: service)
        destination.modalPresentationStyle = .fullScreen
        view.present(destination, animated: true)
    }
    
    func logout() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid configuration!") }
        
        let tabBarController = AuthConfigurator.configure()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

