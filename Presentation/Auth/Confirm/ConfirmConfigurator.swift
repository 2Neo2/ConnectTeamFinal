//
//  ConfirmConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 25.01.2024.
//

import UIKit

protocol ConfirmConfiguratorProtocol {
    static func configure(with id: Int?, _ email: String, _ password: String) -> UIViewController
}

final class ConfirmConfigurator: ConfirmConfiguratorProtocol {
    static func configure(with id: Int?, _ email: String, _ password: String) -> UIViewController {
        let view = ConfirmViewController()
        let service = AuthService()
        let presenter = ConfirmPresenter(userID: id!, email: email, service: service, password: password)
        let router = ConfirmRouter()
        
        view.presenter = presenter
        
        router.view = view
        
        presenter.router = router
        presenter.view = view
        return view
    }
}
