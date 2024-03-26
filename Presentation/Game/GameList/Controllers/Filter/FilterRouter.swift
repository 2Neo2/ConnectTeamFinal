//
//  FilterRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 05.03.2024.
//

import Foundation

protocol FilterRouterProtocol {
    func hideView()
}

final class FilterRouter: FilterRouterProtocol {
    weak var view: FilterViewController?
    
    func hideView() {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
}
