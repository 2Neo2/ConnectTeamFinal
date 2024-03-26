//
//  UserTokenModel.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 12.02.2024.
//

import Foundation

struct UserTokenModel: Decodable {
    let token: String
    let access: String
}
