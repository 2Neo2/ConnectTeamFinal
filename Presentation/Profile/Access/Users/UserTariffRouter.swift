//
//  UserTariffRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 26.03.2024.
//

import Foundation

protocol UserTariffRouterProtocol {
    func hideView()
}

final class UserTariffRouter: UserTariffRouterProtocol {
    weak var view: UserTariffViewController?
    
    func hideView() {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
}
