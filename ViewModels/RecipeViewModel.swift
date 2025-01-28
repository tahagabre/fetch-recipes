import UIKit

class RecipeViewModel {
    var recipe: RecipeResponse
    
    init(recipe: RecipeResponse) {
        self.recipe = recipe
    }
    
    // MARK: Getters
    var cuisine: String {
        return recipe.cuisine
    }
    
    var name: String {
        return recipe.name
    }
    
    var uuid: String {
        return recipe.uuid
    }
    
    // MARK: Optional
    
    var sourceUrl: URL? {
        guard let urlString = recipe.source_url,
              let url = URL(string: urlString) else { return nil }
        
        return url
    }
    
    var videoURL: URL? {
        guard let urlString = recipe.youtube_url,
              let url = URL(string: urlString) else { return nil }
        
        return url
    }
    
    var smallPhotoURL: URL? {
        guard let urlString = recipe.photo_url_small,
              let url = URL(string: urlString) else { return nil }
        
        return url
    }
    
    var largePhotoURL: URL? {
        guard let urlString = recipe.photo_url_large,
              let url = URL(string: urlString) else { return nil }
        
        return url
    }
    
    // MARK: Setters
    var isFavorited: Bool = false
}
