//
//  EmptyRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 22.02.2024.
//

import UIKit


protocol EmptyRouterProtocol {
    func openTariffFlow(with token: String)
}

final class EmptyRouter: EmptyRouterProtocol {
    weak var view: EmptyViewController?
    
    func openTariffFlow(with token: String) {
        guard let view = view else { return }
        
        let destination = TariffConfigurator.configure(with: token)
        destination.modalPresentationStyle = .fullScreen
        view.present(destination, animated: true)
        SnackBar.make(in: destination.view, message: "Выберите тариф!", duration: .lengthLong).show()
    }
}
