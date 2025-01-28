import SwiftUI

class Manager: ObservableObject {
    @Published var recipes: [RecipeViewModel] = []
    @Published var appliedFilters: [String] = []
    
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
