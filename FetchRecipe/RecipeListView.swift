import SwiftUI

class Manager: ObservableObject {
    @Published var recipes: [RecipeViewModel] = []
    @Published var appliedFilters: [String] = []
    
    var cuisineList: [String] {
        return Array(Set(recipes.map { $0.cuisine })).sorted(by: <)
    }
    
    var filteredList: [RecipeViewModel] {
        return recipes.filter { recipe in
            appliedFilters.allSatisfy { filter in
                recipe.cuisine == filter
            }
        }
    }
}

// TODO: Title
struct RecipeListView: View {
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        NavigationStack {
            if manager.recipes.isEmpty {
                ProgressView()
                    .navigationTitle(Text("Fetch Recipes"))
            }
            else {
                VStack {
                    Spacer()
                    FilterListView()
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 26))
                    List(manager.filteredList, id: \.uuid) { recipe in
                        RecipeListCell(recipe: recipe)
                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    }
                }
                .navigationTitle(Text("Fetch Recipes"))
            }
        }
        .progressViewStyle(.circular)
        .onAppear {
            Task {
                do {
                    let fetchedRecipes = try await NetworkManager.getRecipes()
                    manager.recipes = fetchedRecipes.recipes.map { RecipeViewModel(recipe: $0) }
                }
                // TODO: Replacing view when error occurs
                catch let error as FetchError {
                    switch error {
                    case .failedToGetData: Text("failed to get data")
                    case .invalidURL: Text("invalid url")
                    }
                }
            }
        }
    }
}
