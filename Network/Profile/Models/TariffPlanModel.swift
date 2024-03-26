//
//  TariffPlanModel.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 03.03.2024.
//

import Foundation

struct TariffPlanModel: Decodable {
    let duration: Int
    let expiryDate: String
    let holderId: Int
    let id: Int
    let isTrial: Bool
    let planAccess: String
    let planType: String
    let status: String
    let userId: Int
    
    
    enum CodingKeys: String, CodingKey {
        case duration
        case expiryDate = "expiry_date"
        case holderId = "holder_id"
        case id
        case isTrial = "is_trial"
        case planAccess = "plan_access"
        case planType = "plan_type"
        case status
        case userId = "user_id"
    }
}
