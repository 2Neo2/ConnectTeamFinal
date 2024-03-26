//
//  GameService.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 18.03.2024.
//

import Foundation


protocol GameServiceProtocol {
    func fetchGame(with token: String, _ name: String, _ date: String, completion: @escaping (Result<ProfileResult, Error>) -> Void)
}

final class GameService: GameServiceProtocol {
    private let urlSession: URLSession = .shared
    
    func fetchGame(with token: String, _ name: String, _ date: String, completion: @escaping (Result<ProfileResult, any Error>) -> Void) {
        let json: [String: Any] = [
            "name": name,
            "start_date": date
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = createGameRequest(with: token, body: jsonData)
        
//        let task = urlSession.objectTask(for: request) { (result: Result<TariffPlanModel, Error>) in
//            switch result {
//            case .success(let model):
//                
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//        task.resume()
    }
}

extension GameService {
    private func createGameRequest(with token: String, body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/games/", httpMethod: "POST", body: body, token: token)
    }
}
