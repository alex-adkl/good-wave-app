//
//  SurfSpotsModel.swift
//  good-wave
//
//  Created by Théo  on 30/04/2025.
//

import Foundation

struct SurfSpotsData: Codable {
    let records: [SurfSpotRecord]
}

struct SurfSpotRecord: Codable {
    let id: String
    let fields: SurfSpotFields
    let createdTime: String
}

struct SurfSpotFields: Codable {
    let surfBreak: [String]
    let difficultyLevel: Int
    let destination: String
    let geocode: String
    let influencers: [String]
    let magicSeaweedLink: String
    let photos: [Photo]
    let peakSurfSeasonBegins: String

    var formattedPeakSurfSeasonBegins: String {
        return formatDate(peakSurfSeasonBegins)
    }

    var formattedPeakSurfSeasonEnds: String {
        return formatDate(peakSurfSeasonEnds)
    }

    private func formatDate(_ dateString: String) -> String {
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd"
        isoFormatter.locale = Locale(identifier: "en_US")

        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "MMMM d"
        displayFormatter.locale = Locale(identifier: "en_US")

        if let date = isoFormatter.date(from: dateString) {
            return displayFormatter.string(from: date)
        }
        return dateString
    }

    let peakSurfSeasonEnds: String
    let destinationStateCountry: String
    let address: String

    enum CodingKeys: String, CodingKey {
        case surfBreak = "Surf Break"
        case difficultyLevel = "Difficulty Level"
        case destination = "Destination"
        case geocode = "Geocode"
        case influencers = "Influencers"
        case magicSeaweedLink = "Magic Seaweed Link"
        case photos = "Photos"
        case peakSurfSeasonBegins = "Peak Surf Season Begins"
        case peakSurfSeasonEnds = "Peak Surf Season Ends"
        case destinationStateCountry = "Destination State/Country"
        case address = "Address"
    }
}

struct Photo: Codable {
    let id: String
    let url: String
    let filename: String
    let size: Int
    let type: String
    let thumbnails: Thumbnails
}

struct Thumbnails: Codable {
    let small: Thumbnail
    let large: Thumbnail
    let full: Thumbnail
}

struct Thumbnail: Codable {
    let url: String
    let width: Int
    let height: Int
}
