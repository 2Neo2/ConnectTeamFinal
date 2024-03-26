//
//  SelectedTariffRouter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 20.02.2024.
//

import UIKit

protocol SelectedTariffRouterProtocol {
    func hideView()
}

final class SelectedTariffRouter: SelectedTariffRouterProtocol {
    weak var view: SelectedTariffViewController?
    
    func hideView() {
        guard let view = view else { return }
        view.dismiss(animated: true)
    }
    
    func openGeneralFlow() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid configuration!") }
        
        let tabBarController = CustomTabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    func openTariffFlow(with token: String) {
        guard let view = view else { return }
        
        let destination = TariffConfigurator.configure(with: token)
        destination.modalPresentationStyle = .fullScreen
        view.present(destination, animated: true)
        SnackBar.make(in: destination.view, message: "Произошла ошибка попробуйте снова выбрать тариф!", duration: .lengthShort).show()
    }
}
