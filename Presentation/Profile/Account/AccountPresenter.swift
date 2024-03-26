//
//  AccountPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import Foundation

protocol AccountPresenterProtocol {
    func backButtonTapped()
    func logoutButtonTapped()
    func openChangeEmailFlow()
    func openChangePasswordFlow()
}

final class AccountPresenter: AccountPresenterProtocol {
    weak var view: AccountViewController?
    var router: AccountRouter?
    private var profileService: ProfileStorageUserModelService
    
    init(profileService: ProfileStorageUserModelService) {
        self.profileService = profileService
    }
    
    func updateDataOnView() {
        guard let userModel = profileService.currentProfile else { return }
        view?.updateProfileInfo(userModel)
    }
    
    func backButtonTapped() {
        router?.hideView()
    }
    
    func logoutButtonTapped() {
        router?.logout()
    }
    
    func openChangeEmailFlow() {
        router?.openEmailFlow(with: profileService)
    }
    
    func openChangePasswordFlow() {
        router?.openPasswordFlow(with: profileService)
    }
}
