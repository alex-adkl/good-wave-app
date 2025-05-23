//
//  SurfSpotSaveService.swift
//  good-wave
//
//  Created by Alejandra ADEIKALAM on 19/05/2025.
//

import Foundation

class SurfSpotSaveService {
    private let baseURL = "http://192.168.75.242:8080"

    func updateSavedStatus(for id: String, saved: Bool) async throws {
        guard let url = URL(string: "\(baseURL)/api/surf-spots/\(id)") else {
            throw SurfSpotServiceError.invalidURL
        }

        let body: [String: Any] = [
            "saved": saved
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw SurfSpotServiceError.serverUnreachable
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                // Afficher le message d'erreur du serveur si disponible
                if let errorMessage = String(data: data, encoding: .utf8) {
                    print("Erreur serveur: \(errorMessage)")
                }
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
