//
//  SurfSpotViewModel.swift
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

    func loadSurfSpots() {
        let baseID = "appUTGwQsOG0pTRc8"
        let tableName = "Surf%20Destinations"
        let apiKey = "patnTydUsqcjCS3wO.72a9fc74d6485c872cfc16e9328b3b3fa275e54386b9cd7ef842058136b0e1a3" // 🔐 à sécuriser plus tard (ex: dans un fichier .xcconfig)

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
}
