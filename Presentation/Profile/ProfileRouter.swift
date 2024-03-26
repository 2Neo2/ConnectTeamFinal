//
//  ProfileRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 11.01.2024.
//

import Foundation

protocol ProfileRouterProtocol {
    func openAccountInfo(profileService service: ProfileStorageUserModelService)
    func openUserInfo(profileService service: ProfileStorageUserModelService)
    func openUserAccess(profileService service: ProfileStorageUserModelService)
    func openUserCompany(profileService service: ProfileStorageUserModelService)
    func openSettings()
}

final class ProfileRouter: ProfileRouterProtocol {
    weak var view: ProfileViewController?
    
    func openAccountInfo(profileService service: ProfileStorageUserModelService) {
        guard let view else { return }
        let presentVC = AccountConfigurator.configure(profileService: service)
        presentVC.modalPresentationStyle = .fullScreen
        view.present(presentVC, animated: true)
    }
    
    func openUserInfo(profileService service: ProfileStorageUserModelService) {
        guard let view else { return }
        let presentVC = UserDataConfigurator.configure(profileService: service)
        presentVC.modalPresentationStyle = .fullScreen
        view.present(presentVC, animated: true)
    }
    
    func openUserAccess(profileService service: ProfileStorageUserModelService) {
        guard let view else { return }
        let presentVC = AccessConfigurator.configure(profileService: service)
        presentVC.modalPresentationStyle = .fullScreen
        view.present(presentVC, animated: true)
    }
    
    func openUserCompany(profileService service: ProfileStorageUserModelService) {
        guard let view else { return }
        let presentVC = CompanyConfigurator.configure(profileService: service)
        presentVC.modalPresentationStyle = .fullScreen
        view.present(presentVC, animated: true)
    }
    
    func openSettings() {
        guard let view else { return }
        let presentVC = SettingsConfigurator.configure()
        presentVC.modalPresentationStyle = .fullScreen
        view.present(presentVC, animated: true)
    }
}
