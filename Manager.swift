import SwiftUI

class Manager: ObservableObject {
    @Published var recipes: [RecipeViewModel] = []
    @Published var appliedFilters: [String] = []
    
    var imageCache = ImageCache()
    
    var cuisines: [String] {
        return Array(Set(recipes.map { $0.cuisine })).sorted(by: <)
    }
    
    var recipesWithVideo: [RecipeViewModel] {
        return recipes.filter { $0.videoURL != nil }
    }
    
    var recipesWithWebsite: [RecipeViewModel] {
        return recipes.filter { $0.sourceUrl != nil }
    }
    
    var favoritedRecipes: [RecipeViewModel] {
        return recipes.filter { $0.isFavorited == true }
    }
    
    var filteredRecipes: [RecipeViewModel] {
        return recipes.filter { recipe in
            appliedFilters.allSatisfy { filter in
                recipe.cuisine == filter
            }
        }
    }
}

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
