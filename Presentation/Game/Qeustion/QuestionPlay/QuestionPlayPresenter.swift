//
//  QuestionPlayPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 18.03.2024.
//

import Foundation

protocol QuestionPlayPresenterProtocol {
    func openAnswerFlow()
}

final class QuestionPlayPresenter: QuestionPlayPresenterProtocol {
    weak var view: QuestionPlayViewController?
    var router: QuestionPlayRouter?
    
    func openAnswerFlow() {
        router?.openAnswerFlow()
    }
}
