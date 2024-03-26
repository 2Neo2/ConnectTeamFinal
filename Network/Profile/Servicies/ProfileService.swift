//
//  ProfileService.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import Foundation


protocol ProfileServiceProtocol {
    func fetchProfile(with token: String, completion: @escaping (Result<ProfileResult, Error>) -> Void)
    func fetchProfileMe(with token: String, completion: @escaping (Result<TariffResult, Error>) -> Void) 
}

final class ProfileService: ProfileServiceProtocol {
    private let urlSession: URLSession = .shared
    private var isDirty = false
    private var cachedProfile: ProfileResult?
    
    func fetchProfile(with token: String, completion: @escaping (Result<ProfileResult, Error>) -> Void) {
        let request = profileRequest(with: token)
        let task = urlSession.objectTask(for: request) { (result: Result<ProfileResult, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func changePassword(with token: String, _ oldPassword: String, _ newPassword: String, completion: @escaping (Result<StatusModel, Error>) -> Void) {
        let json: [String: Any] = [
            "new_password": "\(newPassword)",
            "old_password": "\(oldPassword)"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = profileChangePasswordRequest(with: token, body: jsonData)
        
        let task = urlSession.objectTask(for: request) { (result: Result<StatusModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func changeCompanyInfo(companyInfo array: Array<String>, with token: String, completion: @escaping (Result<StatusModel, Error>) -> Void) {
        let json: [String: Any] = [
            "company_name": "\(array[0])",
            "company_info": "\(array[1])",
            "company_url": "\(array[2])"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = profileChangeCompanyInfoRequest(with: token, body: jsonData)
        
        let task = urlSession.objectTask(for: request) { (result: Result<StatusModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func changeUserInfo(userInfo array: Array<String>, with token: String, completion: @escaping (Result<StatusModel, Error>) -> Void) {
        let json: [String: Any] = [
            "first_name": "\(array[0])",
            "second_name": "\(array[1])",
            "description": "\(array[2])"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = profileChangeUserInfo(with: token, body: jsonData)
        
        let task = urlSession.objectTask(for: request) { (result: Result<StatusModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchProfileMe(with token: String, completion: @escaping (Result<TariffResult, Error>) -> Void) {
        let request = profileGetPlan(with: token)
        
        let task = urlSession.objectTask(for: request) { (result: Result<TariffResult, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func changeProfileTariff(with token: String, duration value: Int, type plan: String, completion: @escaping (Result<TariffPlanModel, Error>) -> Void) {
        let json: [String: Any] = [
            "duration": value,
            "plan_type": "\(plan)"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = profileChangePlan(with: token, body: jsonData)
        
        let task = urlSession.objectTask(for: request) { (result: Result<TariffPlanModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

extension ProfileService {
    private func profileRequest(with token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/users/me", httpMethod: "GET", token: token)
    }
    
    private func profileChangePasswordRequest(with token: String, body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/users/change-password", httpMethod: "PATCH", body: body, token: token)
    }
    
    private func profileChangeCompanyInfoRequest(with token: String, body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/users/company", httpMethod: "PATCH", body: body, token: token)
    }
    
    private func profileChangeUserInfo(with token: String, body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/users/info", httpMethod: "PATCH", body: body, token: token)
    }
    
    private func profileChangePlan(with token: String, body: Data?) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/plans/purchase", httpMethod: "POST", body: body, token: token)
    }
    
    private func profileGetPlan(with token: String) -> URLRequest {
        URLRequest.makeHttpRequest(path: "/plans/current", httpMethod: "GET", token: token)
    }
}
