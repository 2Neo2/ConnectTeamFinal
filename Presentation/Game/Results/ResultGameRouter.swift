//
//  ResultGameRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 26.03.2024.
//

import Foundation

protocol ResultGameRouterProtocol {
    func openAnswerFlow()
}

final class ResultGameRouter: ResultGameRouterProtocol {
    weak var view: ResultGameViewController?
    
    func openAnswerFlow() {
        guard let view else {return}
        
        let presentVC = AnswerConfigurator.configure()
        presentVC.modalPresentationStyle = .fullScreen
        view.present(presentVC, animated: true)
    }
}
