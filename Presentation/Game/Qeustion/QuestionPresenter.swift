//
//  QuestionPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 17.03.2024.
//

import Foundation

protocol QuestionPresenterProtocol {
    func openPlayFlow()
}

final class QuestionPresenter: QuestionPresenterProtocol {
    weak var view: QuestionViewController?
    var router: QuestionRouter?
    
    func openPlayFlow() {
        router?.openPlayFlow()
    }
}
