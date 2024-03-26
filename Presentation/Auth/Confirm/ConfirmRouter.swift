//
//  ConfirmRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 25.01.2024.
//

import Foundation

protocol ConfirmRouterProtocol {
    func hideView()
    func openTariffFlow(with token: String?)
}

final class ConfirmRouter: ConfirmRouterProtocol {
    weak var view: ConfirmViewController?
    
    func openTariffFlow(with token: String?) {
        guard let view = view, let token = token else { return }
        
        let destination = TariffConfigurator.configure(with: token)
        destination.modalPresentationStyle = .fullScreen
        view.present(destination, animated: true)
        SnackBar.make(in: destination.view, message: "Регистрация прошла успешно.\nВыберите тариф!", duration: .lengthLong).show()
    }
    
    func hideView() {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
}
