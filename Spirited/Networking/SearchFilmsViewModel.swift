//
//  SearchFilmsViewModel.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 18/02/26.
//

import Foundation
import Observation

@Observable
class SearchFilmsViewModel {
    
    var state: LoadingState<[Film]> = .idle
    
    private let service: GhibliService
    
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }
    
    func fetch(with searchTerm: String) async {
        // guard !state.isLoading || state.error != nil else { return }
        guard !searchTerm.isEmpty else {
                    return
                }
        state = .loading
        
        do {
            let films = try await service.searchFilms(with: searchTerm)
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }
}
