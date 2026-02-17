//
//  FilmsViewModel.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 16/01/26.
//

import Foundation
import Observation


@Observable
class FilmsViewModel {
    
    enum State:Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)
    }

    var state: State = .idle
        
    private let service: GhibliService

    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }

    
    func fetch() async {
        guard state == .idle else { return }
        
        state = .loading
        
        do {
            let films = try await service.fetchFilms()
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }


}
