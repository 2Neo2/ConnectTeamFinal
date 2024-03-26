//
//  FilterPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 05.03.2024.
//

import Foundation

protocol FilterPresenterProtocol {
    func hideView()
}

final class FilterPresenter: FilterPresenterProtocol {
    weak var view: FilterViewController?
    var router: FilterRouter?
    
    func hideView() {
        router?.hideView()
    }
}
