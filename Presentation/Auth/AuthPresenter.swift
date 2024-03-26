//
//  AuthPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import Foundation


protocol AuthPresenterProtocol {
    func openRegistrationFlow()
    func openGameFlow(with model: UserAuthModel)
}

final class AuthPresenter: AuthPresenterProtocol {
    var router: AuthRouter?
    private let service: AuthServiceProtocol
    private let profileService: ProfileServiceProtocol
    var view: AuthViewController?
    
    init(service: AuthServiceProtocol, profileService: ProfileServiceProtocol) {
        self.service = service
        self.profileService = profileService
    }
    
    func openRegistrationFlow() {
        router?.openRegistrationFlow()
    }
    
    func openGameFlow(with model: UserAuthModel) {
        service.fetchAuthToken(model: model) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.openTariffFlow()
                case .failure:
                    break
                }
            }
        }
    }
    
    private func openTariffFlow() {
        guard let token = service.userToken else {
            SnackBar.make(in: view!.view, message: "Что-то пошло не так", duration: .lengthShort).show()
            return
        }
        
        print(token)
        
        profileService.fetchProfileMe(with: token) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.router?.openGameFlow()
                case .failure:
                    self.router?.openTariffFlow(with: token)
                }
            }
        }
    }
}
