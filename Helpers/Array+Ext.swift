//
//  Array+Ext.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 13.03.2024.
//

import Foundation


extension Array {
    subscript(safe index: Index) -> Element? {
        indices ~= index ? self[index] : nil
    }
}
