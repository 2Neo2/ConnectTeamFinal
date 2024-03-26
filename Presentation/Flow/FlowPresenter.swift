//
//  FlowPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import Foundation

protocol FlowPresenterProtocol {
    func loadData()
    func fetchProfile(with token: String)
}

final class FlowPresenter: FlowPresenterProtocol {
    
    weak var view: FlowViewControllerProtocol?
    var router: FlowRouter?
    private var storage: AuthStorageProtocol
    private var profileService: ProfileServiceProtocol
    
    init(storage: AuthStorageProtocol, profileService: ProfileServiceProtocol) {
        self.storage = storage
        self.profileService = profileService
    }
    
    func loadData() {
        guard let token = storage.token else {
            router?.openAuthFlow()
            return
        }
        
        fetchProfile(with: token)
    }
    
    func fetchProfile(with token: String) {
        profileService.fetchProfile(with: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.router?.openGameFlow(with: model)
                break
            case .failure:
                break
            }
        }
    }
}
