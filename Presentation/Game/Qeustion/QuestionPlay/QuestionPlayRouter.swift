//
//  QuestionPlayRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 18.03.2024.
//

import Foundation

protocol QuestionPlayRouterProtocol {
    func openAnswerFlow()
}

final class QuestionPlayRouter: QuestionPlayRouterProtocol {
    weak var view: QuestionPlayViewController?
    
    func openAnswerFlow() {
        guard let view else {return}
        
        let presentVC = AnswerConfigurator.configure()
        presentVC.modalPresentationStyle = .fullScreen
        view.present(presentVC, animated: true)
    }
}
