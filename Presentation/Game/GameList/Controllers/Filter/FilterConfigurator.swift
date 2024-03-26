//
//  FilterConfigure.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 05.03.2024.
//

import UIKit

protocol FilterConfiguratorProtocol {
    static func configure(delegate: FilterViewDelegate) -> UIViewController
}

final class FilterConfigurator: FilterConfiguratorProtocol {
    static func configure(delegate: FilterViewDelegate) -> UIViewController {
        let view = FilterViewController()
        let router = FilterRouter()
        let presenter = FilterPresenter()
        
        router.view = view
        presenter.router = router
        view.delegate = delegate
        view.presenter = presenter
        return view
    }
}
