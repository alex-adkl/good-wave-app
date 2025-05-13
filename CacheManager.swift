import Foundation

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