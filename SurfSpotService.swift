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
        // Vérifier d'abord le cache
        if let cachedSpots = CacheManager.shared.getCachedSurfSpots() {
            return cachedSpots
        }
        
        // Si pas en cache, faire la requête réseau
        guard let url = URL(string: "\(baseURL)/surf-spots") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let spots = try decoder.decode([SurfSpot].self, from: data)
        
        // Mettre en cache les résultats
        CacheManager.shared.cacheSurfSpots(spots)
        
        return spots
    }
    
    func submitSpot(name: String, location: String, coordinates: String, difficulty: Int, peakSeasonStart: Date, peakSeasonEnd: Date, websiteLink: String, type: String, imageURL: String) async throws {
        guard let url = URL(string: "\(baseURL)/surf-spots") else {
            throw URLError(.badURL)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let newSpot = [
            "destination": name,
            "destination_state": location,
            "address": coordinates,
            "difficulty_level": difficulty,
            "peak_season_begins": dateFormatter.string(from: peakSeasonStart),
            "peak_season_ends": dateFormatter.string(from: peakSeasonEnd),
            "forecast_url": websiteLink,
            "surf_break": [type],
            "photo_url": imageURL
        ] as [String : Any]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: newSpot)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
