//
//  EmptyPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 22.02.2024.
//

import Foundation


protocol EmptyPresenterProtocol {
    func openTariffFlow()
}

final class EmptyPresenter: EmptyPresenterProtocol {
    var router: EmptyRouter?
    private let service: AuthServiceProtocol
    private let profileService: ProfileServiceProtocol
    
    init(service: AuthServiceProtocol, profileService: ProfileServiceProtocol) {
        self.service = service
        self.profileService = profileService
    }
    
    func openTariffFlow() {
        guard let token = service.userToken else {
            return
        }
        router?.openTariffFlow(with: token)
    }
}
