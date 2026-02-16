//
//  FavoritesViewModel.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 17/02/26.
//



import Foundation
import Observation

@Observable
class FavouritesViewModel {
    
    private(set) var favouriteIDs: Set<String> = []
    
    private let service: FavouriteStorage
  
    init(service: FavouriteStorage = DefaultFavouriteStorage()) {
        self.service = service
    }
    
    func load() {
        favouriteIDs = service.load()
    }
    
    private func save() {
        service.save(favouriteIDs: favouriteIDs)
    }
    
    func toggleFavourite(filmID: String) {
        if favouriteIDs.contains(filmID) {
            favouriteIDs.remove(filmID)
        } else {
            favouriteIDs.insert(filmID)
        }
        
        save()
    }
    
    func isFavourite(filmID: String) -> Bool {
        favouriteIDs.contains(filmID)
    }
    
    // MARK: - preview
    static var example: FavouritesViewModel {
        let vm = FavouritesViewModel(service: MockFavouriteStorage())
        vm.favouriteIDs = ["2baf70d1-42bb-4437-b551-e5fed5a87abe"]
        return vm
    }
}
