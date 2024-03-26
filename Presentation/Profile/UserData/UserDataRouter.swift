//
//  UserDataRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import Foundation

protocol UserDataRouterProtocol {
    func hideView()
}

final class UserDataRouter: UserDataRouterProtocol {
    weak var view: UserDataViewController?
    
    func hideView() {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
}
