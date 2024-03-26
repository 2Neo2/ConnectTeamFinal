//
//  SettingsPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import Foundation

protocol SettingsPresenterProtocol {
    func backButtonTapped()
}

final class SettingsPresenter: SettingsPresenterProtocol {
    var router: SettingsRouter?
    
    func backButtonTapped() {
        router?.hideView()
    }
}
