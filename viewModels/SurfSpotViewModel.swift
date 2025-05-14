//
//  SurfSpotViewModel.swift
//  good-wave
//
//  Created by Théo  on 30/04/2025.
//

import Foundation
import UIKit

@MainActor
class SurfSpotViewModel: ObservableObject {
    @Published var surfSpots: [SurfSpot] = []
    @Published var isLoading = true
    @Published var error: String?
    
    private let service: SurfSpotService
    
    init(service: SurfSpotService = SurfSpotService()) {
        self.service = service
        Task {
            await loadSurfSpots()
        }
    }
    
    func loadSurfSpots() async {
        isLoading = true
        error = nil
        
        do {
            surfSpots = try await service.fetchSurfSpots()
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func submitSpot(name: String, location: String, coordinates: String, difficulty: Int, peakSeasonStart: Date, peakSeasonEnd: Date, websiteLink: String, type: String, imageURL: String, forecastURL: String) async throws {
        try await service.submitSpot(
            name: name,
            location: location,
            coordinates: coordinates,
            difficulty: difficulty,
            peakSeasonStart: peakSeasonStart,
            peakSeasonEnd: peakSeasonEnd,
            websiteLink: websiteLink,
            type: type,
            imageURL: imageURL,
            //forecastURL: forecastURL
        )
        await loadSurfSpots() // Recharger la liste après l'ajout
    }
}
