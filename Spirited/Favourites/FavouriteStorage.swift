//
//  FavouriteStorage.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 17/02/26.
//


import Foundation

protocol FavouriteStorage {
    func load() -> Set<String>
    func save(favouriteIDs: Set<String>)
}
