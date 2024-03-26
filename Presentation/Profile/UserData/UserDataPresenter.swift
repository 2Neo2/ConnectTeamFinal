//
//  UserDataPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import Foundation

protocol UserDataPresenterProtocol {
    func backButtonTapped()
}

final class UserDataPresenter: UserDataPresenterProtocol {
    weak var view: UserDataViewController?
    private var profileService: ProfileStorageUserModelService
    var router: UserDataRouter?
    private var profileNetwork: ProfileService
    
    init(profileService: ProfileStorageUserModelService, network: ProfileService) {
        self.profileService = profileService
        self.profileNetwork = network
    }
    
    func updateDataOnView() {
        guard let userModel = profileService.currentProfile else { return }
        view?.updateProfileInfo(userModel)
    }
    
    func changeUserData(_ name: String, _ surname: String, _ info: String) {
        profileService.markDirty()
        guard let token = profileService.authStorage.token else { return }
        profileNetwork.changeUserInfo(userInfo: [name, surname, info], with: token){ [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    SnackBar(contextView: self.view!.view, message: "Данные были успешно изменены!", duration: .lengthShort).show()
                case .failure:
                    self.view?.showSomeError()
                }
            }
        }
    }
    
    func backButtonTapped() {
        router?.hideView()
    }
}
