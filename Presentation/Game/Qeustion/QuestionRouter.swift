//
//  QuestionRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 17.03.2024.
//

import Foundation

protocol QuestionRouterProtocol {
    func openPlayFlow()
}

final class QuestionRouter: QuestionRouterProtocol {
    weak var view: QuestionViewController?
    
    func openPlayFlow() {
        guard let view else {return}
        
        let presentVC = QuestionPlayConfigurator.configure()
        presentVC.modalPresentationStyle = .fullScreen
        view.present(presentVC, animated: true)
    }
}
