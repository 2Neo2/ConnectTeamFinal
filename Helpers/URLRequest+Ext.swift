//
//  URLRequest+Ext.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 23.01.2024.
//

import Foundation

extension URLRequest {
    
    static func makeHttpRequest(path: String, httpMethod: String, body: Data? = nil, token: String? = nil) -> URLRequest {
        let route = Constants.API.defaultBaseURL + path
        var request = URLRequest(url: URL(string: route)!)
        if let body = body {
            request.httpBody = body
        }
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = httpMethod
        return request
    }
}
