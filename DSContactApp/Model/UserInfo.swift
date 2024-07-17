//
//  UserInfo.swift
//  DSContactApp
//
//  Created by 머성이 on 7/12/24.
//

import Foundation

struct UserInfo: Codable {
    let main: [User]
}

struct User: Codable {
    var id: UUID
    var name: String
    var phoneNumber: String
    var profileImageData: Data?
}
