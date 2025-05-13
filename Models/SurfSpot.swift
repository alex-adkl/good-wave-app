//
//  SurfSpot.swift
//  good-wave
//
//  Created by Alejandra ADEIKALAM on 05/05/2025.
//

import Foundation

struct SurfSpot: Identifiable, Codable {
    let id: String
    let photoURL: String
    let destination: String
    let destinationState: String
    let peakSeasonBegins: String
    let peakSeasonEnds: String
    let surfBreak: [String]
    let difficultyLevel: Int
    let address: String
    let forecastURL: String?
    
    var formattedPeakSeasonBegins: String {
        return formatDate(peakSeasonBegins)
    }
    
    var formattedPeakSeasonEnds: String {
        return formatDate(peakSeasonEnds)
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case photoURL = "photo_url"
        case destination
        case destinationState = "destination_state"
        case peakSeasonBegins = "peak_season_begins"
        case peakSeasonEnds = "peak_season_ends"
        case surfBreak = "surf_break"
        case difficultyLevel = "difficulty_level"
        case address
        case forecastURL = "forecast_url"
    }
}
