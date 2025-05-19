//
//  SurfSpotSaveService.swift
//  good-wave
//
//  Created by Alejandra ADEIKALAM on 19/05/2025.
//

import Foundation

class SurfSpotSaveService {
    private let baseURL = "http://localhost:8080"

    func updateSavedStatus(for id: String, saved: Bool) async throws {
        guard let url = URL(string: "\(baseURL)/api/surf-spots/\(id)") else {
            throw SurfSpotServiceError.invalidURL
        }

        let body: [String: Any] = [
            "destination": id,
            "saved": saved
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw SurfSpotServiceError.serverUnreachable
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw SurfSpotServiceError.invalidResponse(httpResponse.statusCode)
        }
    }
}
