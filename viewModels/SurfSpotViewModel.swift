//
//  SufSpotViewModel.swift
//  good-wave
//
//  Created by Théo  on 30/04/2025.
//

import Foundation

class SurfSpotViewModel: ObservableObject {
    @Published var surfSpots: [SurfSpot] = []

    init() {
        loadSurfSpots()
    }

    func loadSurfSpots() {
        if let url = Bundle.main.url(forResource: "surfSpots", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode(SurfSpotsData.self, from: data)
                self.surfSpots = decodedData.records.map { SurfSpot(from: $0) }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("surfSpots.json not found.")
        }
    }
}
