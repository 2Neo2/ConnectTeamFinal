//
//  RegistrationRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import Foundation


protocol RegistrationRouterProtocol {
    func openSignInFlow()
    func openCofirmFlow(with id: Int?, _ email: String,  _ password: String)
}

final class RegistrationRouter: RegistrationRouterProtocol {
    weak var view: RegistrationViewController?
    
    func openSignInFlow() {
        guard let view = view else { return }
        
        let destination = AuthConfigurator.configure()
        destination.modalPresentationStyle = .fullScreen
        view.present(destination, animated: true)
    }
    
    func openCofirmFlow(with id: Int?, _ email: String, _ password: String) {
        guard let view = view else { return }
        
        let destination = ConfirmConfigurator.configure(with: id, email, password)
        destination.modalPresentationStyle = .fullScreen
        view.present(destination, animated: true)
    }
}
