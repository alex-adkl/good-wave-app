import Foundation

extension SurfSpot {
    // Méthode pour créer un SurfSpot à partir d'un SurfSpotRecord
    static func from(_ record: SurfSpotRecord) -> SurfSpot {
        return SurfSpot(
            id: record.id,
            photoURL: record.fields.photoURL,
            destination: record.fields.destination,
            destinationState: record.fields.destinationState,
            peakSeasonBegins: record.fields.peakSeasonBegins,
            peakSeasonEnds: record.fields.peakSeasonEnds,
            surfBreak: record.fields.surfBreak,
            difficultyLevel: record.fields.difficultyLevel,
            address: "",
            forecastURL: record.fields.forecastURL
        )
    }
    
    // Méthode générique pour créer un SurfSpot à partir de n'importe quel objet
    static func from(_ object: Any) -> SurfSpot {
        // Valeurs par défaut
        let defaultSpot = SurfSpot(
            id: UUID().uuidString,
            photoURL: "https://example.com/default.jpg",
            destination: "Default Destination",
            destinationState: "Default Location",
            peakSeasonBegins: "2025-01-01",
            peakSeasonEnds: "2025-12-31",
            surfBreak: ["Unknown"],
            difficultyLevel: 3,
            address: "Unknown Address",
            forecastURL: "https://example.com/default.jpg"
        )
        
        return defaultSpot
    }
}
