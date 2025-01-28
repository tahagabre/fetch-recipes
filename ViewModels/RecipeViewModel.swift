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
    
    var source_url: String? {
        return recipe.source_url
    }
    
    var youtube_url: String? {
        return recipe.youtube_url
    }
    
    var smallPhotoURL: URL? {
        guard let urlString = recipe.photo_url_small,
              let url = URL(string: urlString) else { return nil }
        
        return url
    }
    
    // MARK: Setters
    var isFavorited: Bool = false
}
