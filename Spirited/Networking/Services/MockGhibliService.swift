//
//  MockGhibliService.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 17/01/26.
//

import Foundation
struct MockGhibliService: GhibliService {
    func fetchFilms() async throws -> [Film] {
        return []
    }
}
