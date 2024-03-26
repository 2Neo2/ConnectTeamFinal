//
//  QuestionConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 17.03.2024.
//

import UIKit

protocol QuestionConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class QuestionConfigurator: QuestionConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = QuestionViewController()
        let presenter = QuestionPresenter()
        let router = QuestionRouter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        
        presenter.view = view
        
        return view
    }
}
