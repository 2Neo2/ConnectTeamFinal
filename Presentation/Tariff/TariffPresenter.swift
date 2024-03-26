//
//  TariffPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 18.02.2024.
//

import Foundation

protocol TariffPresenterProtocol {
    func openSelectedTariff(with model: TariffViewModel)
}

final class TariffPresenter: TariffPresenterProtocol {
    var router: TariffRouter?
    private var token: String
    private var profileNetwork: ProfileService
    
    init(network: ProfileService, token: String) {
        self.profileNetwork = network
        self.token = token
    }
    
    func openSelectedTariff(with model: TariffViewModel) {
        router?.openSelectedTariff(with: self.token, and: model)
    }
    
    func openGameFlow() {
        router?.openGameFlow()
    }
}
