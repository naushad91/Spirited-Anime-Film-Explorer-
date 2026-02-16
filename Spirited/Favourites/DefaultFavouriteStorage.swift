//
//  DefaultFavouriteStorage.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 17/02/26.
//


import Foundation

struct DefaultFavouriteStorage: FavouriteStorage {
    
    private let favouritesKey = "GhibliExplorer.FavouritesFilms"
    
    func load() -> Set<String> {
        let array = UserDefaults.standard.stringArray(forKey: favouritesKey) ?? []
        return Set(array)
    }
    
    func save(favouriteIDs: Set<String>) {
        UserDefaults.standard.set(Array(favouriteIDs), forKey: favouritesKey)
    }
}
