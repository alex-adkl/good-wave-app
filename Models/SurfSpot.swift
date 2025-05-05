//
//  SurfSpot.swift
//  good-wave
//
//  Created by Alejandra ADEIKALAM on 05/05/2025.
//

import Foundation

struct SurfSpot: Identifiable {
    let id: String
    let fields: SurfSpotFields

    struct SurfSpotFields {
        let imageURL: String
        let title: String
        let location: String
        let dateRange: String
        let rating: Int
        let condition: String
        let forecastURL: String
    }

    var imageName: String { fields.imageURL }
    var title: String { fields.title }
    var location: String { fields.location }
    var dateRange: String { fields.dateRange }
    var rating: Int { fields.rating }
    var condition: String { fields.condition }
    var forecastURL: String { fields.forecastURL }
}
