struct RecipesResponse: Codable {
    let recipes: [RecipeResponse]
}

struct RecipeResponse: Codable, Hashable {
    // MARK: Required
    let cuisine: String
    let name: String
    let uuid: String
    
    // MARK: Optional
    let photo_url_large: String?
    let photo_url_small: String?
    let source_url: String?
    let youtube_url: String?
}
