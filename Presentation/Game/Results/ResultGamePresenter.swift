//
//  ResultGamePresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 26.03.2024.
//

import Foundation

protocol ResultGamePresenterProtocol {
    func openAnswerFlow()
}

final class ResultGamePresenter: ResultGamePresenterProtocol {
    weak var view: ResultGameViewController?
    var router: ResultGameRouter?
    
    func openAnswerFlow() {
        router?.openAnswerFlow()
    }
}
