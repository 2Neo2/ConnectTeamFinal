//
//  AnswerPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 18.03.2024.
//

import Foundation

protocol AnswerPresenterProtocol {
    func openAnswerFlow()
}

final class AnswerPresenter: AnswerPresenterProtocol {
    weak var view: AnswerViewController?
    var router: AnswerRouter?
    
    func openAnswerFlow() {
        router?.openTabBarController()
    }
}
