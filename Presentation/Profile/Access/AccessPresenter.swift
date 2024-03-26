//
//  AccessPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import Foundation

protocol AccessPresenterProtocol {
    func backButtonTapped()
}

final class AccessPresenter: AccessPresenterProtocol {
    weak var view: AccessViewController?
    var router: AccessRouter?
    private var service: ProfileStorageUserModelService
    private var profileService: ProfileService
    
    init(profileService: ProfileStorageUserModelService, service: ProfileService) {
        self.service = profileService
        self.profileService = service
    }
    
    func backButtonTapped() {
        router?.hideView()
    }
    
    func getMyPlan() {
        guard let token = service.authStorage.token else {
            SnackBar.make(in: view!.view, message: "Что-то пошло не так", duration: .lengthShort).show()
            return
        }
        
        profileService.fetchProfileMe(with: token) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.view?.updateProfileInfo(model)
                case .failure:
                    self.view?.showSomeError()
                }
            }
        }
    }
    
    func openUserTariffFlow() {
        router?.openUserTariffFlow(with: self.service)
    }
    
    func openTarifFlow() {
        guard let token = service.authStorage.token else {
            SnackBar.make(in: view!.view, message: "Что-то пошло не так", duration: .lengthShort).show()
            return
        }
        
        router?.openTariffFlow(with: token)
    }
}
