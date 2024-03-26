//
//  CustomTabBarController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import UIKit
import Foundation

class CustomTabBarController : UITabBarController {
    private lazy var  buttonMiddle : UIButton = {
        let button = GradientButton()
        button.imageView?.contentMode = .scaleToFill
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonMiddleTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.circleTabBar
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
        addSomeTabItems()
    }
    
    override func loadView() {
        super.loadView()
        self.setValue(CustomTabBar(), forKey: "tabBar")
        self.tabBar.addSubview(buttonMiddle)
        self.buttonMiddle.addSubview(plusImageView)
        layoutView()
    }
    
    @objc private func buttonMiddleTapped() {
        selectedIndex = 1
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            buttonMiddle.heightAnchor.constraint(equalToConstant: 60),
            buttonMiddle.widthAnchor.constraint(equalToConstant: 60),
            buttonMiddle.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            buttonMiddle.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -50),
            
            plusImageView.heightAnchor.constraint(equalToConstant: 35),
            plusImageView.widthAnchor.constraint(equalToConstant: 35),
            plusImageView.centerXAnchor.constraint(equalTo: buttonMiddle.centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: buttonMiddle.centerYAnchor)
        ])
    }
    
    private func addSomeTabItems() {
        let gameVC = configureTabBarItems(for: GameListConfigurator.configure(), with: UIImage(systemName: "gamecontroller") ?? UIImage(), UIImage(systemName: "gamecontroller.fill") ?? UIImage(), with: "Игры")
        let profileVC = configureTabBarItems(for: ProfileConfigurator.configure(), with: UIImage(systemName: "person.crop.circle") ?? UIImage(), UIImage(systemName: "person.crop.circle.fill") ?? UIImage(), with: "Аккаунт")
        viewControllers = [gameVC, GamePlayViewController(), profileVC]
    }
    
    private func configureTabBarItems(for controller: UIViewController, with image: UIImage, _ selected: UIImage, with text: String) -> UIViewController {
        controller.tabBarItem.image = image.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.selectedImage = selected.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.title = text
        return UINavigationController(rootViewController: controller)
    }
}
