//
//  SelectedTariffPresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 20.02.2024.
//

import Foundation

protocol SelectedTariffPresenterProtocol {
    func backButtonTapped()
}

final class SelectedTariffPresenter: SelectedTariffPresenterProtocol {
    weak var view: SelectedTariffViewController?
    var router: SelectedTariffRouter?
    private var profileNetwork: ProfileService
    private var token: String
    private var model: TariffViewModel
    
    init(network: ProfileService, token: String, model: TariffViewModel) {
        self.profileNetwork = network
        self.token = token
        self.model = model
    }
    
    func updateDataOnView() {
        view?.updateLabels(with: self.model)
    }
    
    func buyTariff() {
        var duration = 0
        var type = ""
        print(model.title)
        switch model.title {
        case "Широкий":
            duration = 30
            type = "premium"
        case "Расширенный":
            duration = 30
            type = "advanced"
        case "Простой":
            duration = 14
            type = "basic"
        default:
            SnackBar.make(in: view!.view, message: "Произшла ошибка, попробуйте еще раз!", duration: .lengthShort).show()
            return
        }
        
        profileNetwork.changeProfileTariff(with: self.token, duration: duration, type: type) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.router?.openGeneralFlow()
                case .failure:
                    self.router?.openTariffFlow(with: self.token)
                }
            }
        }
    }
    
    func backButtonTapped() {
        router?.hideView()
    }
}
