//
//  SufSpotViewModel.swift
//  good-wave
//
//  Created by Théo  on 30/04/2025.
//

import Foundation

class SurfSpotViewModel: ObservableObject {
    @Published var surfSpots: [SurfSpot] = []
    @Published var isLoading = true

    init() {
        loadSurfSpots()
    }

    func loadSurfSpots(completion: (() -> Void)? = nil) {
        if let url = Bundle.main.url(forResource: "surfSpots", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode(SurfSpotsData.self, from: data)
                self.surfSpots = decodedData.records.map { SurfSpot(from: $0) }
                
                // Précharger les images
                for spot in self.surfSpots {
                    if let imageUrl = URL(string: spot.imageName) {
                        URLSession.shared.dataTask(with: imageUrl) { _, _, _ in }.resume()
                    }
                }
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    completion?()
                }
            } catch {
                print("Error decoding JSON: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                    completion?()
                }
            }
        } else {
            print("surfSpots.json not found.")
            DispatchQueue.main.async {
                self.isLoading = false
                completion?()
            }
        }
    }
}
