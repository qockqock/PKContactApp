//
//  Pokemon.swift
//  DSContactApp
//
//  Created by 머성이 on 7/12/24.
//

import Foundation

struct Pokemon: Codable {
    let list: [PokemonInfo]
}

struct PokemonInfo: Codable {
    let main: UserInfo
}
