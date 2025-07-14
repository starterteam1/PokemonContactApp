//
//  ImageResponse.swift
//  PokemonContactApp
//
//  Created by 김이든 on 7/9/25.
//

import Foundation

struct ImageResponse: Decodable {
    let sprites: Sprites
}

struct Sprites: Decodable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
