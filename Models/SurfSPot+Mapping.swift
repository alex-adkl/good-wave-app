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
