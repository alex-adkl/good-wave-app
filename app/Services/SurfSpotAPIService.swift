//
//  SurfSpotAPIService.swift
//  good-wave
//
//  Created by Alejandra ADEIKALAM on 13/05/2025.
//

import Foundation

enum SurfSpotServiceError: Error, LocalizedError {
    case networkUnavailable
    case invalidURL
    case invalidResponse(Int)
    case decodingError(Error)
    case serverUnreachable
    
    var errorDescription: String? {
        switch self {
        case .networkUnavailable:
            return "Connexion réseau indisponible"
        case .invalidURL:
            return "URL invalide"
        case .invalidResponse(let statusCode):
            return "Réponse serveur invalide: \(statusCode)"
        case .decodingError:
            return "Erreur de format de données"
        case .serverUnreachable:
            return "Serveur inaccessible. Vérifiez que le serveur local est en cours d'exécution sur le port 8080."
        }
    }
}

class SurfSpotService {
    // URL locale par défaut
    private var baseURL = "http://localhost:8080"
    private var currentURLIndex = 0
    private let alternativeURLs = [
        "http://localhost:8080",
        // Fichier local pour les tests
        "file:///\(Bundle.main.bundlePath)/data.json",
        "https://raw.githubusercontent.com/theo/surfspots-demo/main/spots.json"
    ]
    
    init() {
        // Commencer avec l'URL locale
        baseURL = alternativeURLs[currentURLIndex]
    }
    
    private func switchToNextURL() {
        currentURLIndex = (currentURLIndex + 1) % alternativeURLs.count
        baseURL = alternativeURLs[currentURLIndex]
        print("Switched to alternative URL: \(baseURL)")
    }
    
    func fetchSurfSpots() async throws -> [SurfSpot] {
        // Vérifier d'abord le cache
        if let cachedSpots = CacheManager.shared.getCachedSurfSpots() {
            return cachedSpots
        }
        
        // Essayer avec l'URL actuelle
        do {
            return try await fetchFromCurrentURL()
        } catch {
            // Si ça échoue, essayer avec les URL alternatives
            if currentURLIndex < alternativeURLs.count - 1 {
                switchToNextURL()
                return try await fetchFromCurrentURL()
            } else {
                throw error
            }
        }
    }
    
    private func fetchFromCurrentURL() async throws -> [SurfSpot] {
        // Si pas en cache, faire la requête réseau
        var urlString = "\(baseURL)"
        if !urlString.contains(".json") {
            urlString += "/surf-spots"
        }
        
        guard let url = URL(string: urlString) else {
            throw SurfSpotServiceError.invalidURL
        }
        
        print("Tentative de récupération depuis: \(url.absoluteString)")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw SurfSpotServiceError.serverUnreachable
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw SurfSpotServiceError.invalidResponse(httpResponse.statusCode)
            }
            
            // Afficher le JSON reçu pour débogage
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON reçu:")
                print(jsonString)
            }
            
            let decoder = JSONDecoder()
            
            // Décodage direct uniquement
            do {
                let spots = try decoder.decode([SurfSpot].self, from: data)
                CacheManager.shared.cacheSurfSpots(spots)
                return spots
            } catch {
                print("Erreur lors du décodage: \(error)")
                throw SurfSpotServiceError.decodingError(error)
            }
        } catch {
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    throw SurfSpotServiceError.networkUnavailable
                case .cannotConnectToHost, .cannotFindHost:
                    throw SurfSpotServiceError.serverUnreachable
                default:
                    print("URLError non géré: \(urlError)")
                    throw error
                }
            } else {
                throw error
            }
        }
    }
    
    func submitSpot(name: String, location: String, coordinates: String, difficulty: Int, peakSeasonStart: Date, peakSeasonEnd: Date, websiteLink: String, type: String, imageURL: String) async throws {
        guard let url = URL(string: "\(baseURL)/api/surf-spots") else {
            throw SurfSpotServiceError.invalidURL
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let country = location // Assuming 'country' should be derived or passed differently; here we assign location to country for demonstration

        let newSpot: [String: Any] = [
            "destination": name,
            "address": location,
            "country": country,
            "difficulty": difficulty,
            "season_start": dateFormatter.string(from: peakSeasonStart),
            "season_end": dateFormatter.string(from: peakSeasonEnd),
            "link": websiteLink,
            "surf_break": [type],
            "photo": imageURL,
            "geocode": coordinates
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: newSpot)

            let (_, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw SurfSpotServiceError.serverUnreachable
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw SurfSpotServiceError.invalidResponse(httpResponse.statusCode)
            }
        } catch {
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    throw SurfSpotServiceError.networkUnavailable
                case .cannotConnectToHost, .cannotFindHost:
                    throw SurfSpotServiceError.serverUnreachable
                default:
                    throw error
                }
            } else {
                throw error
            }
        }
    }
}
