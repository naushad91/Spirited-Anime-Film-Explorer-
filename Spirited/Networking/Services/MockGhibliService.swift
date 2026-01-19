//
//  MockGhibliService.swift
//  Spirited
//
//  Created by Naushad Ali Khan on 17/01/26.
//

import Foundation

struct MockGhibliService: GhibliService {
    
    private struct SampleData: Decodable {
        let films: [Film]
        let people: [Person]
    }
    
    private func loadSampleData() throws -> SampleData {
        guard let url = Bundle.main.url(forResource: "SampleData", withExtension: "json") else {
            throw APIError.invalidURL
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(SampleData.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    // MARK: - GhibliService conformance
    func fetchFilms() async throws -> [Film] {
        let data = try loadSampleData()
        return data.films
    }

    func fetchPerson(from URLString: String) async throws -> Person {
        let data = try loadSampleData()
        return data.people.first!
    }

    // MARK: - preview/testing only
    func fetchFilm() -> [Film] {
        let data = try! loadSampleData()
        return data.films
    }

}
