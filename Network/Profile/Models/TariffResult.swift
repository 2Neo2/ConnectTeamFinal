//
//  TariffResult.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 25.02.2024.
//

import Foundation

struct TariffResult: Decodable {
    let expiryDate: String
    let holderId: Int
    let id: Int
    let isTrial: Bool
    let planAccess: String
    let planType: String
    let status: String
    let userId: Int
    let invitationCode: String
    
    
    enum CodingKeys: String, CodingKey {
        case expiryDate = "expiry_date"
        case holderId = "holder_id"
        case id
        case isTrial = "is_trial"
        case planAccess = "plan_access"
        case planType = "plan_type"
        case status
        case userId = "user_id"
        case invitationCode = "invitation_code"
    }
}
