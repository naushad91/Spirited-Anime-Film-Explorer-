//
//  GhibliService.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 17/01/26.
//

import Foundation


protocol GhibliService {
    func fetchFilms() async throws -> [Film]
}
