//
//  Person.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 15/01/26.
//

import Foundation

struct Person: Identifiable, Decodable , Equatable{
    let id: String
    let name: String
    let gender: String
    let age: String
    let eyeColor: String
    let hairColor: String
    let films: [String]
    let species: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, name, gender, age, films, species, url
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
    }
}
