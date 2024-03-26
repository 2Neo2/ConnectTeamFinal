//
//  AnswerRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 18.03.2024.
//

import UIKit

protocol AnswerRouterProtocol {
    
}

final class AnswerRouter: AnswerRouterProtocol {
    weak var view: AnswerViewController?
    
    func openTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid configuration!") }
        
        let tabBarController = CustomTabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
