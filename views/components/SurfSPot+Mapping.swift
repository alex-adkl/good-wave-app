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
            dateRange: "\(record.fields.peakSurfSeasonBegins) - \(record.fields.peakSurfSeasonEnds)",
            rating: record.fields.difficultyLevel,
            condition: "Good" 
        )
    }
}
