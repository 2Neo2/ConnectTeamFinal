//
//  ProfilePresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 11.01.2024.
//

import Foundation

protocol ProfilePresenterProtocol {
    func openAccountFlow()
    func openInfoUserDataFlow()
    func openAccessFlow()
    func openCompanyFlow()
    func openSettingsFlow()
    func hideView()
}

final class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewController?
    var router: ProfileRouter?
    private var profileService: ProfileStorageUserModelService
    
    init(profileService: ProfileStorageUserModelService) {
        self.profileService = profileService
    }
    
    func openAccountFlow() {
        router?.openAccountInfo(profileService: profileService)
    }
    
    func openInfoUserDataFlow() {
        router?.openUserInfo(profileService: profileService)
    }
    
    func openAccessFlow() {
        router?.openUserAccess(profileService: profileService)
    }
    
    func openCompanyFlow() {
        router?.openUserCompany(profileService: profileService)
    }
    
    func openSettingsFlow() {
        router?.openSettings()
    }
    
    func hideView() {
        view?.dismiss(animated: true)
    }
    
    func updateDataOnView() {
        guard let userModel = profileService.currentProfile else { return }
        view?.updateProfileInfo(userModel)
    }
}
