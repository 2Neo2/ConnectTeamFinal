//
//  UserTariffPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 26.03.2024.
//

import Foundation

protocol UserTariffPresenterProtocol {
    func backButtonTapped()
}

final class UserTariffPresenter: UserTariffPresenterProtocol {
    weak var view: UserTariffViewController?
    var router: UserTariffRouter?
    private var service: ProfileStorageUserModelService
    private var profileService: ProfileService
    
    init(profileService: ProfileStorageUserModelService, service: ProfileService) {
        self.service = profileService
        self.profileService = service
    }
    
    func backButtonTapped() {
        router?.hideView()
    }
}
