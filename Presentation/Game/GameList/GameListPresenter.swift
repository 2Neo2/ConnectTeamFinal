//
//  GameListPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 04.03.2024.
//

import Foundation
protocol GameListPresenterProtocol {
    func openFilterFlow()
    func didCellTapped(with model: GameDataModel)
}

final class GameListPresenter: GameListPresenterProtocol {
    weak var view: GameListViewController?
    var router: GameListRouter?
    
    func openFilterFlow() {
        router?.openFilterFlow()
    }
    
    func didCellTapped(with model: GameDataModel) {
        switch model.status {
        case "в процессе":
            router?.openGameFlow()
        case "не начата":
            view?.animateInfoMassage()
        case "завершена":
            router?.openGameResultFlow()
        default:
            view?.animateSomeError()
        }
    }
}
