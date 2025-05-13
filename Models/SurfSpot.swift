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
    
    // Initialisation pour compatibilité avec les appels existants
    init(_ id: String, _ photoURL: String, _ destination: String, _ destinationState: String, 
         _ peakSeasonBegins: String, _ peakSeasonEnds: String, _ surfBreak: [String],
         _ difficultyLevel: Int, _ address: String, _ forecastURL: String?) {
        
        self.id = id
        self.photoURL = photoURL
        self.destination = destination
        self.destinationState = destinationState
        self.peakSeasonBegins = peakSeasonBegins
        self.peakSeasonEnds = peakSeasonEnds
        self.surfBreak = surfBreak
        self.difficultyLevel = difficultyLevel
        self.address = address
        self.forecastURL = forecastURL
    }
    
    // Initialisation standard avec paramètres nommés
    init(id: String, photoURL: String, destination: String, destinationState: String,
         peakSeasonBegins: String, peakSeasonEnds: String, surfBreak: [String],
         difficultyLevel: Int, address: String, forecastURL: String? = nil) {
        
        self.id = id
        self.photoURL = photoURL
        self.destination = destination
        self.destinationState = destinationState
        self.peakSeasonBegins = peakSeasonBegins
        self.peakSeasonEnds = peakSeasonEnds
        self.surfBreak = surfBreak
        self.difficultyLevel = difficultyLevel
        self.address = address
        self.forecastURL = forecastURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Décodage de l'ID avec fallback
        do {
            id = try container.decode(String.self, forKey: .id)
        } catch {
            // Si l'ID est un entier, le convertir en chaîne
            if let idInt = try? container.decode(Int.self, forKey: .id) {
                id = String(idInt)
            } else {
                // Générer un ID aléatoire si aucun ID n'est trouvé
                id = UUID().uuidString
                print("ID généré aléatoirement: \(id)")
            }
        }
        
        // Décodage obligatoire avec valeurs par défaut si nécessaire
        photoURL = try container.decodeIfPresent(String.self, forKey: .photoURL) ?? ""
        destination = try container.decodeIfPresent(String.self, forKey: .destination) ?? "Sans titre"
        destinationState = try container.decodeIfPresent(String.self, forKey: .destinationState) ?? "Emplacement inconnu"
        peakSeasonBegins = try container.decodeIfPresent(String.self, forKey: .peakSeasonBegins) ?? "2025-01-01"
        peakSeasonEnds = try container.decodeIfPresent(String.self, forKey: .peakSeasonEnds) ?? "2025-12-31"
        
        // Décodage du tableau avec fallback
        do {
            surfBreak = try container.decode([String].self, forKey: .surfBreak)
        } catch {
            // Essayer de décoder une seule chaîne
            if let singleValue = try? container.decode(String.self, forKey: .surfBreak) {
                surfBreak = [singleValue]
            } else {
                surfBreak = ["Unknown"]
            }
        }
        
        // Décodage de l'entier avec fallback
        do {
            difficultyLevel = try container.decode(Int.self, forKey: .difficultyLevel)
        } catch {
            // Essayer de décoder une chaîne numérique
            if let levelString = try? container.decode(String.self, forKey: .difficultyLevel),
               let levelInt = Int(levelString) {
                difficultyLevel = levelInt
            } else {
                difficultyLevel = 1
            }
        }
        
        address = try container.decodeIfPresent(String.self, forKey: .address) ?? "Adresse non spécifiée"
        forecastURL = try container.decodeIfPresent(String.self, forKey: .forecastURL)
    }
}
