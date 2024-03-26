//
//  ProfileStorageUserModelService.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 13.02.2024.
//

import Foundation

final class ProfileStorageUserModelService {
    private let profileService: ProfileService?
    
    private var isDirty = false
    private var cachedProfile: ProfileResult?
    var authStorage: AuthStorage
    
    
    var currentProfile: UserModel? {
        if cachedProfile == nil || isDirty {
            updateProfile()
        }
        
        let result = makeModel(cachedProfile)
        return result
    }
    
    init(profileService: ProfileService, authStorage: AuthStorage) {
        self.profileService = profileService
        self.authStorage = authStorage
    }
    
    func markDirty() {
        isDirty = true
    }
    
    func updateProfile() {
        guard let token = authStorage.token else { return }
        profileService?.fetchProfile(with: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.cachedProfile = model
            case .failure:
                break
            }
        }
        isDirty = false
    }
    
    private func makeModel(_ model: ProfileResult?) -> UserModel? {
        guard let model = model else { return nil }
        return UserModel(
            access: model.access ?? "",
            companyInfo: model.companyInfo ?? "",
            companyLogo: model.companyLogo ?? "",
            companyURL: model.companyURL ?? "",
            companyName: model.companyName ?? "",
            description: model.description ?? "",
            email: model.email ?? "",
            firstName: model.firstName ?? "",
            id: model.id ?? 0,
            profileImage: model.profileImage ?? "",
            secondName: model.secondName ?? ""
        )
    }
}
