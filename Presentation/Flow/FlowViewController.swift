//
//  FlowViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import UIKit

protocol FlowViewControllerProtocol: AnyObject {
    func showAlertSomeError()
}

final class FlowViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = Constants.Images.logo
        return image
    }()
    
    var presenter: FlowPresenter?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupView()
        insertView()
        layotView()
        presenter?.loadData()
    }

    private func setupView() {
        view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    private func layotView() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func insertView() {
        view.addSubview(imageView)
    }
}

extension FlowViewController: FlowViewControllerProtocol {
    func showAlertSomeError() {
        
    }
}
