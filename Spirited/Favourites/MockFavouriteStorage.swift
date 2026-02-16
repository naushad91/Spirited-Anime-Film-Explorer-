//
//  MockFavouriteStorage.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 17/02/26.
//


import Foundation

struct MockFavouriteStorage: FavouriteStorage {
    
    func load() -> Set<String> {
        ["2baf70d1-42bb-4437-b551-e5fed5a87abe"]
    }
    
    func save(favouriteIDs: Set<String>) {
        
    }
}
``
