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
    private let saveService: SurfSpotSaveService
    
    init(service: SurfSpotService = SurfSpotService(), saveService: SurfSpotSaveService = SurfSpotSaveService()) {
        self.service = service
        self.saveService = saveService
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
    
    func toggleSaved(for spot: SurfSpot) {
        Task {
            do {
                let updatedSaved = !spot.saved
                try await saveService.updateSavedStatus(for: spot.id, saved: updatedSaved)
                if let index = surfSpots.firstIndex(where: { $0.id == spot.id }) {
                    surfSpots[index] = SurfSpot(
                        id: spot.id,
                        photoURL: spot.photoURL,
                        destination: spot.destination,
                        country: spot.country,
                        peakSeasonBegins: spot.peakSeasonBegins,
                        peakSeasonEnds: spot.peakSeasonEnds,
                        surfBreak: spot.surfBreak,
                        difficultyLevel: spot.difficultyLevel,
                        address: spot.address,
                        forecastURL: spot.forecastURL,
                        geocode: spot.geocode,
                        saved: updatedSaved
                    )
                }
            } catch {
                print("Erreur lors du toggle saved : \(error)")
            }
        }
    }
}
