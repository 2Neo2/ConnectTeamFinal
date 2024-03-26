//
//  EmailChangeRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 29.01.2024.
//

import Foundation


protocol EmailChangeRouterProtocol {
    func hideView()
}

final class EmailChangeRouter: EmailChangeRouterProtocol {
    weak var view: EmailChangeViewController?
    
    func hideView() {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
}
