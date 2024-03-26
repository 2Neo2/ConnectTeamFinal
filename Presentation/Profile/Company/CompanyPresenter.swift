//
//  CompanyPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import Foundation

protocol CompanyPresenterProtocol {
    func backButtonTapped()
    func updateDataOnView()
    func saveData(values array: Array<String>)
}

final class CompanyPresenter: CompanyPresenterProtocol {
    var router: CompanyRouter?
    weak var view: CompanyViewController?
    
    private var profileService: ProfileStorageUserModelService
    private var profileNetwork: ProfileService
    
    init(profileService: ProfileStorageUserModelService, network: ProfileService) {
        self.profileService = profileService
        self.profileNetwork = network
    }
    
    func saveData(values array: Array<String>) {
        profileService.markDirty()
        guard let token = profileService.authStorage.token else { return }
        profileNetwork.changeCompanyInfo(companyInfo: array, with: token) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    SnackBar(contextView: self.view!.view, message: "Данные успешно изменены!", duration: .lengthShort).show()
                case .failure:
                    self.view?.showSomeError()
                }
            }
        }
    }
    
    func updateDataOnView() {
        guard let userModel = profileService.currentProfile else { return }
        view?.updateProfileInfo(userModel)
    }
    
    func backButtonTapped() {
        router?.hideView()
    }
}
