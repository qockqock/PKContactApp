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
    let name: String
    let phoneNumber: String
    var profileImageData: Data?
}
