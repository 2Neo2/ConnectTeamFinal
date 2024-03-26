//
//  AnswerConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 18.03.2024.
//

import UIKit

protocol AnswerConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class AnswerConfigurator: AnswerConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = AnswerViewController()
        let presenter = AnswerPresenter()
        let router = AnswerRouter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        
        presenter.view = view
        
        return view
    }
}
