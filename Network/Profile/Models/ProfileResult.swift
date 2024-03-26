//
//  ProfileResult.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 10.01.2024.
//

import Foundation

struct ProfileResult: Decodable {
    let access: String?
    let companyInfo: String?
    let companyLogo: String?
    let companyURL: String?
    let companyName: String?
    let description: String?
    let email: String?
    let firstName: String?
    let id: Int?
    let profileImage: String?
    let secondName: String?
    
    enum CodingKeys: String, CodingKey {
        case access
        case companyInfo = "company_info"
        case companyLogo = "company_logo"
        case companyURL = "company_url"
        case companyName = "company_name"
        case description
        case email
        case firstName = "first_name"
        case id
        case profileImage = "profile_image"
        case secondName = "second_name"
    }
}
