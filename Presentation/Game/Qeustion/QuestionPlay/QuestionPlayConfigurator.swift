//
//  QuestionPlayConfigurator.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 18.03.2024.
//

import UIKit

protocol QuestionPlayConfiguratorProtocol {
    static func configure() -> UIViewController
}

final class QuestionPlayConfigurator: QuestionPlayConfiguratorProtocol {
    static func configure() -> UIViewController {
        let view = QuestionPlayViewController()
        let presenter = QuestionPlayPresenter()
        let router = QuestionPlayRouter()
        
        view.presenter = presenter
        router.view = view
        presenter.router = router
        
        return view
    }
}
