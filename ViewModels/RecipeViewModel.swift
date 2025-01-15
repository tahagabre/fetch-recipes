import UIKit

class RecipeViewModel {
    var recipe: RecipeResponse
    
    init(recipe: RecipeResponse) {
        self.recipe = recipe
    }
    
    // MARK: Required
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
    
    lazy var largePhoto: UIImage = {
        if let urlString = recipe.photo_url_large,
           let largeUrl = URL(string: urlString),
           let data = try? Data(contentsOf: largeUrl),
           let image = UIImage(data: data) {
            return image
        }
        
        return UIImage()
    }()
    
    lazy var smallPhoto: UIImage = {
        if let urlString = recipe.photo_url_small,
           let largeUrl = URL(string: urlString),
           let data = try? Data(contentsOf: largeUrl),
           let image = UIImage(data: data) {
            return image
        }
        
        return UIImage()
    }()
}
