//
//  LoadingState.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 18/02/26.
//

import Foundation

enum LoadingState<T> {
    case idle
    case loading
    case loaded(T)
    case error(String)
    
    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
    
    var data: T? {
        if case .loaded(let value) = self { return value }
        return nil
    }
    
    var error: String? {
        if case .error(let message) = self { return message }
        return nil
    }
}
