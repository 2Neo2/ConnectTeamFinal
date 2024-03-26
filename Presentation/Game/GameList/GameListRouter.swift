//
//  GameListRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 04.03.2024.
//

import UIKit
protocol GameListRouterProtocol {
    func openFilterFlow()
}

final class GameListRouter: GameListRouterProtocol {
    weak var view: GameListViewController?
    
    func openFilterFlow() {
        guard let view else {return}
        
        let presentVC = FilterConfigurator.configure(delegate: view)
        
        view.navigationController?.topViewController?.present(presentVC, animated: true, completion: nil)
    }
    
    func openGameFlow() {
        view?.present(QuestionConfigurator.configure(), animated: true)
    }
    
    func openGameResultFlow() {
        view?.navigationController?.pushViewController(ResultGameViewController(), animated: true)
    }
}

