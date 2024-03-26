//
//  EmailChangePresenter.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 29.01.2024.
//

import Foundation


protocol EmailChangePresenterProtocol {
    func changePassword()
    func hideView()
}

final class EmailChangePresenter: EmailChangePresenterProtocol {
    var router: EmailChangeRouter?
    
    func changePassword() {
        
    }
    
    func hideView() {
        router?.hideView()
    }
}
