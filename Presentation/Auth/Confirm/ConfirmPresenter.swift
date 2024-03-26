//
//  Presenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 25.01.2024.
//

import Foundation

protocol ConfirmPresenterProtocol {
    func checkCofirmCode(with code: String)
    func loadCode()
    func backButtonTapped()
}

final class ConfirmPresenter: ConfirmPresenterProtocol {
    
    var router: ConfirmRouter?
    private var userID: Int
    private var email: String
    private var password: String
    private var service: AuthServiceProtocol
    weak var view: ConfirmViewController?
    
    init(userID: Int, email: String, service: AuthServiceProtocol, password: String) {
        self.userID = userID
        self.email = email
        self.service = service
        self.password = password
    }
    
    func loadCode() {
        service.fetchConfirmCode(with: self.email) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    break
                case .failure:
                    self.view?.showSomeError()
                }
            }
        }
    }
    
    func checkCofirmCode(with code: String) {
        service.fetchVerifyUser(with: userID, code) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.openTariffFlow()
                case .failure:
                    self.view?.showSomeError()
                }
            }
        }
    }
    
    func openTariffFlow() {
        let model = UserAuthModel(email: self.email, password: self.password)
        service.fetchAuthToken(model: model) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    let token = self.service.userToken
                    self.router?.openTariffFlow(with: token)
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
