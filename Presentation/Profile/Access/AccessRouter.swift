//
//  AccessRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import Foundation

protocol AccessRouterProtocol {
    func hideView()
}

final class AccessRouter: AccessRouterProtocol {
    weak var view: AccessViewController?
    
    func hideView() {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
    
    func openTariffFlow(with token: String?) {
        guard let view = view, let token = token else { return }
        
        let destination = TariffConfigurator.configure(with: token)
        destination.modalPresentationStyle = .fullScreen
        view.present(destination, animated: true)
    }
    
    func openUserTariffFlow(with service: ProfileStorageUserModelService) {
        guard let view = view else { return }
        let destination = UserTariffConfigurator.configure(profileService: service)
        destination.modalPresentationStyle = .fullScreen
        view.present(destination, animated: true)
    }
}
