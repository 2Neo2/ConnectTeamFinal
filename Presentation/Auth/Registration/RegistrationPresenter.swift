//
//  RegistrationPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import Foundation


protocol RegistrationPresenterProtocol {
    func openSignInFlow()
    func showEmpyAlert()
    func openCofirmFlow(with model: UserRegistrationModel)
}


final class RegistrationPresenter: RegistrationPresenterProtocol {
    weak var view: RegistrationViewController?
    var router: RegistrationRouter?
    private var service: AuthServiceProtocol
    private var storage: AuthStorageProtocol
    
    init(authService: AuthServiceProtocol, storage: AuthStorageProtocol) {
        self.service = authService
        self.storage = storage
    }
    
    func openSignInFlow() {
        router?.openSignInFlow()
    }
    
    func showEmpyAlert() {
        view?.openEmptyFieldError()
    }
    
    func openCofirmFlow(with model: UserRegistrationModel) {
        service.fetchUserId(model: model) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let userID):
                    self.router?.openCofirmFlow(with: userID, model.email, model.password)
                case .failure:
                    self.view?.openEmptyFieldError()
                }
            }
        }
    }
}
