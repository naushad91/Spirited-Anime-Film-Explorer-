//
//  GhibliService.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 17/01/26.
//

import Foundation


protocol GhibliService:Sendable {
    func fetchFilms() async throws -> [Film]
    func fetchPerson(from URLString: String) async throws -> Person
    
    //For searching
    func searchFilms(with searchTerm: String) async throws -> [Film]
}
