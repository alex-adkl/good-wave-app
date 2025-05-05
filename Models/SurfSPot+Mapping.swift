//
//  SurfSpot+Mapping.swift
//  good-wave
//
//  Created by Théo  on 30/04/2025.
//

import Foundation

extension SurfSpot {
    init(from record: SurfSpotRecord) {
        let fields = SurfSpot.SurfSpotFields(
            imageURL: record.fields.photos.first?.url ?? "https://via.placeholder.com/300",
            title: record.fields.destination,
            location: record.fields.destinationStateCountry,
            dateRange: "\(record.fields.formattedPeakSurfSeasonBegins) - \(record.fields.formattedPeakSurfSeasonEnds)",
            rating: record.fields.difficultyLevel,
            condition: record.fields.surfBreak.joined(separator: ", "),
            forecastURL: record.fields.forecastURL ?? record.fields.magicSeaweedLink
        )
        self.init(id: record.id, fields: fields)
    }

    static let example = SurfSpot(
        id: "exampleID",
        fields: SurfSpot.SurfSpotFields(
            imageURL: "https://images.unsplash.com/photo-1455264745730-cb3b76250ae8",
            title: "Pipeline",
            location: "Oahu, Hawaii",
            dateRange: "22/07 - 01/08",
            rating: 4,
            condition: "Reef Break",
            forecastURL: "https://www.surfline.com/surf-report/pipeline/..."
        )
    )
}
