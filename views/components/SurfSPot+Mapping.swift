//
//  SurfSPot+Mapping.swift
//  good-wave
//
//  Created by Théo  on 30/04/2025.
//
import Foundation

extension SurfSpot {
    init(from record: SurfSpotRecord) {
        self.init(
            imageName: record.fields.photos.first?.url ?? "placeholder",
            title: record.fields.destination,
            location: record.fields.destinationStateCountry,
            dateRange: "\(record.fields.formattedPeakSurfSeasonBegins) - \(record.fields.formattedPeakSurfSeasonEnds)",
            rating: record.fields.difficultyLevel,
            condition: "Good" 
        )
    }
}

extension SurfSpot {
    static let example = SurfSpot(
        imageName: "https://images.unsplash.com/photo-1455264745730-cb3b76250ae8",
        title: "Pipeline",
        location: "Oahu, Hawaii",
        dateRange: "22/07 - 01/08",
        rating: 4,
        condition: "Reef Break",
        forecastURL: "https://www.surfline.com/surf-report/pipeline/..."
    )
}
