//
//  GameViewController.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 19.01.2024.
//

import UIKit

final class GameListViewController: UIViewController {
    private let customFilterView = CustomFilterView()
    
    private var currentGameType: GameListType = .personal {
        didSet {
            print("did set")
            // TODO: Update TableView
        }
    }
    
    var presenter: GameListPresenter?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GameListCell.self, forCellReuseIdentifier: GameListCell.reuseIdentifier)
        tableView.separatorColor = .clear
        tableView.backgroundColor = Constants.Colors.backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var array = [
        GameDataModel(gameName: "Игра 1", status: "в процессе", date: "12.01.2023"),
        GameDataModel(gameName: "Игра 2", status: "не начата", date: "12.01.2023"),
        GameDataModel(gameName: "Игра 3", status: "в процессе", date: "12.01.2023"),
        GameDataModel(gameName: "Игра 4", status: "не начата", date: "12.01.2023"),
        GameDataModel(gameName: "Игра 5", status: "в процессе", date: "12.01.2023"),
        GameDataModel(gameName: "Игра 6", status: "не начата", date: "12.01.2023"),
        GameDataModel(gameName: "Игра 7", status: "в процессе", date: "12.01.2023"),
        GameDataModel(gameName: "Игра 8", status: "в процессе", date: "12.01.2023"),
        GameDataModel(gameName: "Игра 9", status: "завершена", date: "12.01.2023"),
        GameDataModel(gameName: "Игра 10", status: "в процессе", date: "12.01.2023"),
        GameDataModel(gameName: "Игра 11", status: "в процессе", date: "12.01.2023"),
        GameDataModel(gameName: "Игра 12", status: "в процессе", date: "12.01.2023"),
        GameDataModel(gameName: "Игра 13", status: "завершена", date: "12.01.2023"),
        GameDataModel(gameName: "Игра 14", status: "в процессе", date: "12.01.2023"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.backgroundColor
        setupViews()
        addSubviews()
        layoutViews()
    }
}

extension GameListViewController {
    private func setupViews() {
        view.backgroundColor = Constants.Colors.backgroundColor
        customFilterView.delegate = self
    }
    
    private func layoutViews() {
        customFilterView.pinHorizontal(to: view, 10)
        
        NSLayoutConstraint.activate([
            customFilterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            customFilterView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            customFilterView.topAnchor.constraint(equalTo: view.topAnchor, constant: 68),
            customFilterView.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: customFilterView.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
        ])
    }
    
    private func addSubviews() {
        view.addSubview(customFilterView)
        view.addSubview(tableView)
    }
}

extension GameListViewController: CustomFilterViewDelegate {
    func changeContentType(with type: GameListType) {
        self.currentGameType = type
        print(self.currentGameType)
    }
    
    func changeContentByFilter() {
        presenter?.openFilterFlow()
    }
}

extension GameListViewController: FilterViewDelegate {
    func openGameList(with: FilterDataModel) {
        print("Filter Button tapped")
    }
}


extension GameListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameListCell.reuseIdentifier, for: indexPath)
        
        guard let gameModel = array[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        guard let gameListCell = cell as? GameListCell else {
            return UITableViewCell()
        }
        
        gameListCell.configureCell(for: gameModel)
        
        gameListCell.selectionStyle = .none
        
        return gameListCell
    }
}

extension GameListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGame = array[indexPath.row]
        presenter?.didCellTapped(with: selectedGame)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        83
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

extension GameListViewController {
    func animateInfoMassage() {
        SnackBar.make(in: self.view, message: "Пожалуйста, дождитесь начала игры!", duration: .lengthShort).show()
    }
    
    func animateSomeError() {
        
    }
}
