import Foundation

// Service de données mock pour éviter de dépendre d'une API externe
class MockSurfSpotService: SurfSpotService {
    // Remplacer la méthode fetchSurfSpots pour fournir des données locales
    override func fetchSurfSpots() async throws -> [SurfSpot] {
        let json = """
        [
            {
                "id": "1",
                "photo": "https://images.unsplash.com/photo-1455264745730-cb3b76250ae8",
                "destination": "Piline",
                "country": "Oahu, Hawaii",
                "season_start": "2024-07-22",
                "season_end": "2024-08-31",
                "surf_break": ["Reef Break"],
                "difficulty": 5,
                "address": "Banzai Pipeline, Ehukai Beach Park, Haleiwa, HI 96712",
                "link": "https://www.surfline.com/surf-report/pipeline/584204214e65fad6a7709b6d"
            },
            {
                "id": "2",
                "photo": "https://images.unsplash.com/photo-1502680390469-be75c86b636f",
                "destination": "Teahupo'o",
                "country": "Tahiti, French Polynesia",
                "season_start": "2024-05-01",
                "season_end": "2024-09-30",
                "surf_break": ["Reef Break"],
                "difficulty": 5,
                "address": "Teahupo'o, Tahiti, French Polynesia",
                "link": "https://www.surfline.com/surf-report/teahupoo/584204204e65fad6a7708957"
            },
            {
                "id": "3",
                "photo": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
                "destination": "Supertubes",
                "country": "Jeffreys Bay, South Africa",
                "season_start": "2024-06-01",
                "season_end": "2024-08-31",
                "surf_break": ["Point Break"],
                "difficulty": 4,
                "address": "Jeffreys Bay, South Africa",
                "link": "https://www.surfline.com/surf-report/jeffreys-bay/584204214e65fad6a7709c29"
            }
        ]
        """
        let data = Data(json.utf8)
        let decoder = JSONDecoder()
        return try decoder.decode([SurfSpot].self, from: data)
    }
    
    // Simuler la soumission d'un nouveau spot
    override func submitSpot(name: String, location: String, coordinates: String, difficulty: Int, peakSeasonStart: Date, peakSeasonEnd: Date, websiteLink: String, type: String, imageURL: String) async throws {
        // Simuler un délai de réseau
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 seconde
        
        // Réussir sans erreur
        print("Spot soumis avec succès (mock)")
    }
} 
