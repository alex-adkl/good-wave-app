//
//  SurfSpotViewModel.swift
//  good-wave
//
//  Created by Théo  on 30/04/2025.
//

import Foundation
import UIKit

class SurfSpotViewModel: ObservableObject {
    @Published var surfSpots: [SurfSpot] = []
    @Published var isLoading = true
    @Published var error: String?

    init() {
        loadSurfSpots()
    }

    func loadSurfSpots() {
        let baseID = "appUTGwQsOG0pTRc8"
        let tableName = "Surf%20Destinations"
        let apiKey = APIConfig.apiKey

        guard let url = URL(string: "https://api.airtable.com/v0/\(baseID)/\(tableName)") else {
            print("URL invalide")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erreur API: \(error)")
                return
            }

            guard let data = data else {
                print("Aucune donnée reçue")
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(SurfSpotsData.self, from: data)
                DispatchQueue.main.async {
                    self.surfSpots = decodedData.records.map { SurfSpot(from: $0) }
                }
            } catch {
                print("Erreur de décodage: \(error)")
            }
        }.resume()
    }
    
    func submitSpot(name: String, location: String, coordinates: String, difficulty: Int, peakSeasonStart: Date, peakSeasonEnd: Date, websiteLink: String, type: String, imageURL: String, completion: @escaping (Bool) -> Void) {
        let baseID = "appUTGwQsOG0pTRc8"
        let tableName = "Surf%20Destinations"
        let apiKey = APIConfig.apiKey
        
        guard let url = URL(string: "https://api.airtable.com/v0/\(baseID)/\(tableName)") else {
            print("URL invalide")
            completion(false)
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDate = dateFormatter.string(from: peakSeasonStart)
        let endDate = dateFormatter.string(from: peakSeasonEnd)
        
        let newSpot: [String: Any] = [
            "fields": [
                "Destination": name,
                "Destination State/Country": location,
                "Geocode": coordinates,
                "Difficulty Level": difficulty,
                "Peak Surf Season Begins": startDate,
                "Peak Surf Season Ends": endDate,
                "Magic Seaweed Link": websiteLink,
                "Surf Break": [type],
                "Photos": imageURL.isEmpty ? [] : [["url": imageURL]]
            ]
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: newSpot)
        } catch {
            print("Erreur de sérialisation: \(error)")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Erreur API: \(error)")
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Réponse invalide du serveur")
                completion(false)
                return
            }
            
            DispatchQueue.main.async {
                self?.loadSurfSpots()
                completion(true)
            }
        }.resume()
    }
}
