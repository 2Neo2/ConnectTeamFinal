//
//  FlowRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import Foundation

protocol FlowRouterProtocol {
    func openGameFlow(with profileModel: ProfileResult)
    func openAuthFlow()
}

final class FlowRouter: FlowRouterProtocol {
    
    weak var view: FlowViewController?
    
    func openAuthFlow() {
        guard let view = view else { return }
        
        let destination = AuthConfigurator.configure()
        destination.modalPresentationStyle = .fullScreen
        view.present(destination, animated: true)
    }
    
    func openGameFlow(with profileModel: ProfileResult) {
        guard let view = view else { return }
        
        let destination = CustomTabBarController()
        destination.modalPresentationStyle = .fullScreen
        view.present(destination, animated: true)
    }
}
