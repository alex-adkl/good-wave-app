//
//  CacheManager.swift.swift
//  good-wave
//
//  Created by Alejandra ADEIKALAM on 13/05/2025.
//

class CacheManager {
    static let shared = CacheManager()
    private let cache = NSCache<NSString, NSArray>()
    
    private init() {}
    
    func cacheSurfSpots(_ spots: [SurfSpot]) {
        cache.setObject(spots as NSArray, forKey: "surfSpots")
    }
    
    func getCachedSurfSpots() -> [SurfSpot]? {
        return cache.object(forKey: "surfSpots") as? [SurfSpot]
    }
}

// Mise à jour du service pour utiliser le cache
class SurfSpotService {
    // ... code existant ...
    
    func fetchSurfSpots() async throws -> [SurfSpots] {
        // Vérifier d'abord le cache
        if let cachedSpots = CacheManager.shared.getCachedSurfSpots() {
            return cachedSpots
        }
        
        // Si pas en cache, faire la requête
        let spots = try await performNetworkRequest()
        
        // Mettre en cache les résultats
        CacheManager.shared.cacheSurfSpots(spots)
        
        return spots
    }
    
    private func performNetworkRequest() async throws -> [SurfSpot] {
        // ... code de la requête réseau existant ...
    }
}
