//
//  FilmDetailViewModel.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 18/01/26.
//

import Foundation
import Observation

@Observable
class FilmDetailViewModel {

    let service: GhibliService
    var people: [Person] = []
    var isLoading = false
    var errorMessage: String?

    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }

    func fetch(for film: Film) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let results = try await withThrowingTaskGroup(of: Person.self) { group in
                
                for personInfoURL in film.people {
                    group.addTask {
                        try await self.service.fetchPerson(from: personInfoURL)
                    }
                }
                
                var fetchedPeople: [Person] = []
                
                for try await person in group {
                    fetchedPeople.append(person)
                }
                
                return fetchedPeople
            }
            
            self.people = results
            isLoading = false
            
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
}

