//
//  CompanyRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import Foundation

protocol CompanyRouterProtocol {
    func hideView()
}

final class CompanyRouter: CompanyRouterProtocol {
    weak var view: CompanyViewController?
    
    func hideView() {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
}
