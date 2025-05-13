import Foundation

// Service de données mock pour éviter de dépendre d'une API externe
class MockSurfSpotService: SurfSpotService {
    // Remplacer la méthode fetchSurfSpots pour fournir des données locales
    override func fetchSurfSpots() async throws -> [SurfSpot] {
        // Créer des données de test
        let spots = [
            SurfSpot(
                id: "1",
                photoURL: "https://images.unsplash.com/photo-1455264745730-cb3b76250ae8",
                destination: "Piline",
                destinationState: "Oahu, Hawaii",
                peakSeasonBegins: "2024-07-22",
                peakSeasonEnds: "2024-08-31",
                surfBreak: ["Reef Break"],
                difficultyLevel: 5,
                address: "Banzai Pipeline, Ehukai Beach Park, Haleiwa, HI 96712",
                forecastURL: "https://www.surfline.com/surf-report/pipeline/584204214e65fad6a7709b6d"
            ),
            SurfSpot(
                id: "2",
                photoURL: "https://images.unsplash.com/photo-1502680390469-be75c86b636f",
                destination: "Teahupo'o",
                destinationState: "Tahiti, French Polynesia",
                peakSeasonBegins: "2024-05-01",
                peakSeasonEnds: "2024-09-30",
                surfBreak: ["Reef Break"],
                difficultyLevel: 5,
                address: "Teahupo'o, Tahiti, French Polynesia",
                forecastURL: "https://www.surfline.com/surf-report/teahupoo/584204204e65fad6a7708957"
            ),
            SurfSpot(
                id: "3",
                photoURL: "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
                destination: "Supertubes",
                destinationState: "Jeffreys Bay, South Africa",
                peakSeasonBegins: "2024-06-01",
                peakSeasonEnds: "2024-08-31",
                surfBreak: ["Point Break"],
                difficultyLevel: 4,
                address: "Jeffreys Bay, South Africa", 
                forecastURL: "https://www.surfline.com/surf-report/jeffreys-bay/584204214e65fad6a7709c29"
            )
        ]
        
        return spots
    }
    
    // Simuler la soumission d'un nouveau spot
    override func submitSpot(name: String, location: String, coordinates: String, difficulty: Int, peakSeasonStart: Date, peakSeasonEnd: Date, websiteLink: String, type: String, imageURL: String) async throws {
        // Simuler un délai de réseau
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 seconde
        
        // Réussir sans erreur
        print("Spot soumis avec succès (mock)")
    }
} 
