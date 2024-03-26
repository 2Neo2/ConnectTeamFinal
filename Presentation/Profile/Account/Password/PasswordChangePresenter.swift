//
//  PasswordChangePresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 29.01.2024.
//

import Foundation

protocol PasswordChangePresenterProtocol {
    func changePassword(_ password: String, _ newPassword: String)
    func hideView()
}

final class PasswordChangePresenter: PasswordChangePresenterProtocol {
    weak var view: PasswordChangeViewController?
    var router: PasswordChangeRouter?
    private var profileService: ProfileStorageUserModelService
    private var profileNetwork: ProfileService
    
    init(profileService: ProfileStorageUserModelService, network: ProfileService) {
        self.profileService = profileService
        self.profileNetwork = network
    }
    
    func changePassword(_ password: String, _ newPassword: String) {
        guard let token = profileService.authStorage.token else { return }
        profileNetwork.changePassword(with: token, password, newPassword) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    SnackBar(contextView: self.view!.view, message: "Пароль был успешно изменен!", duration: .lengthShort).show()
                case .failure:
                    self.view?.showSomeError()
                }
            }
        }
    }
    
    func hideView() {
        router?.hideView()
    }
}
