//
//  AuthService.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import Foundation

protocol AuthServiceProtocol {
    func fetchUserId(model:  UserRegistrationModel, completion: @escaping(Result<Int?, Error>) -> Void)
    func fetchConfirmCode(with email: String, completion: @escaping (Result<Int?, Error>) -> Void)
    func fetchVerifyUser(with id: Int, _ code: String, completion: @escaping (Result<Int?, Error>) -> Void)
    func fetchAuthToken(model: UserAuthModel, completion: @escaping (Result<String?, Error>) -> Void)
    var userToken: String? { get set }
}

final class AuthService: AuthServiceProtocol {
    
    private let urlSession: URLSession = .shared
    
    var authUserID: Int? {
        get {
            AuthStorage().userID
        }
        
        set {
            AuthStorage().userID = newValue
        }
    }
    
    var userToken: String? {
        get {
            return AuthStorage().token
        }
        
        set {
            AuthStorage().token = newValue
        }
    }
    
    func fetchAuthToken(model: UserAuthModel, completion: @escaping (Result<String?, Error>) -> Void) {
        let json: [String: Any] = [
            "email": "\(model.email)",
            "password": "\(model.password)"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = authTokenRequest(body: jsonData)
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<UserTokenModel, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                let token = model.token
                self.userToken = token
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchUserId(model: UserRegistrationModel, completion: @escaping (Result<Int?, Error>) -> Void) {
        let json: [String: Any] = [
            "email": "\(model.email)",
            "first_name": "\(model.name)",
            "second_name": "\(model.surname)",
            "password": "\(model.password)"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = regIdRequest(body: jsonData)
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<UserIdModel, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                let userID = model.id
                self.authUserID = userID
                completion(.success(userID))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchConfirmCode(with email: String, completion: @escaping (Result<Int?, Error>) -> Void) {
        let json: [String: Any] = [
            "email":"\(email)"
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = regConfirmRequest(body: jsonData)
        
        let task = urlSession.objectTask(for: request) { (result: Result<UserIdModel, Error>) in
            switch result {
            case .success(let model):
                let userID = model.id
                completion(.success(userID))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchVerifyUser(with id: Int, _ code: String, completion: @escaping (Result<Int?, Error>) -> Void) {
        let json: [String: Any] = [
            "id": "\(id)",
            "code": "\(code)"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = regVerifyUser(body: jsonData)
        
        let task = urlSession.objectTask(for: request) { (result: Result<UserIdModel, Error>) in
            switch result {
            case .success(let model):
                let userID = model.id
                completion(.success(userID))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

extension AuthService {
    private func authTokenRequest(body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/auth/sign-in/email", httpMethod: "POST", body: body)
    }
    
    private func regIdRequest(body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/auth/sign-up", httpMethod: "POST", body: body)
    }
    
    private func regConfirmRequest(body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/auth/verify-email", httpMethod: "POST", body: body)
    }
    
    private func regVerifyUser(body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/auth/verify-user", httpMethod: "POST", body: body)
    }
}
