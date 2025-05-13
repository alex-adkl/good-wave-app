//
//  SurfSpotService.swift
//  good-wave
//
//  Created by Alejandra ADEIKALAM on 13/05/2025.
//

import Foundation

class SurfSpotService {
    private let baseURL = "http://localhost:8080"
    
    func fetchSurfSpots() async throws -> [SurfSpot] {
        guard let url = URL(string: "\(baseURL)/surf-spots") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode([SurfSpot].self, from: data)
    }
}
