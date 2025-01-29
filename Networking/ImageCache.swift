import SwiftUI

class ImageCache {
    private var cache = NSCache<NSString, NSData>()
    
    public func retrieve(key: String?) -> NSData? {
        if let key = key, let cachedObject = cache.object(forKey: key as NSString) {
            return cachedObject
        }
        
        return nil
    }
    
    public func set(key: String, data: NSData) {
        cache.setObject(data, forKey: key as NSString)
    }
    
    public func wipe() {
        cache.removeAllObjects()
    }
}
