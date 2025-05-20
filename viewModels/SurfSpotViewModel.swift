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
    @Published var isLoading = false
    @Published var error: String?
    @Published var currentPage = 1
    @Published var totalPages = 1
    let pageSize = 10
    
    private let service: SurfSpotService
    private let saveService: SurfSpotSaveService
    
    init(service: SurfSpotService = SurfSpotService(), saveService: SurfSpotSaveService = SurfSpotSaveService()) {
        self.service = service
        self.saveService = saveService
        Task {
            await loadFirstPage()
        }
    }
    
    func loadFirstPage(forceRefresh: Bool = false) async {
        isLoading = true
        error = nil
        do {
            let response = try await service.fetchSurfSpots(page: 1, pageSize: pageSize, forceRefresh: forceRefresh)
            self.surfSpots = response.data
            self.currentPage = response.page
            self.totalPages = response.totalPages
            self.isLoading = false
        } catch {
            self.error = error.localizedDescription
            self.isLoading = false
        }
    }

    func loadNextPage() async {
        guard !isLoading, currentPage < totalPages else { return }
        isLoading = true
        do {
            let nextPage = currentPage + 1
            let response = try await service.fetchSurfSpots(page: nextPage, pageSize: pageSize)
            self.surfSpots += response.data
            self.currentPage = response.page
            self.totalPages = response.totalPages
            self.isLoading = false
        } catch {
            self.error = error.localizedDescription
            self.isLoading = false
        }
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
        await loadFirstPage() // Recharger la liste après l'ajout
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
    
    func filteredSpots(selectedType: String?, searchText: String) -> [SurfSpot] {
        var spots = surfSpots
        if let selectedType = selectedType {
            spots = spots.filter { $0.surfBreak.contains(selectedType) }
        }
        if !searchText.isEmpty {
            spots = spots.filter {
                $0.destination.localizedCaseInsensitiveContains(searchText) ||
                $0.address.localizedCaseInsensitiveContains(searchText)
            }
        }
        return spots
    }
}
