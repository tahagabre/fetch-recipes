import SwiftUI

struct FetchHomeView: View {
    @EnvironmentObject var manager: Manager
    @State var error: FetchError?
    
    var body: some View {
        NavigationStack {
            switch error {
            case .emptyResponse:
                Text("We retrieved no recipes")
                    .navigationTitle("Fetch Recipes")
            case nil:
                RecipeListView()
                    .navigationTitle("Fetch Recipes")
                    .progressViewStyle(.circular)
            case .badData:
                Text("We've received bad data from the server")
                    .navigationTitle("Fetch Recipes")
            default:
                Text("Experiencing errors")
                    .navigationTitle("Fetch Recipes")
            }
        }
//        .progressViewStyle(.circular)
        .refreshable {
            manager.imageCache.wipe()
            error = await fetchRecipes()
        }
        .onAppear {
            Task {
                manager.imageCache.wipe()
                error = await fetchRecipes()
            }
        }
    }
    
    func fetchRecipes() async -> FetchError? {
        do {
            if let fetchedRecipes = try await NetworkManager.getRecipes() {
                manager.recipes = fetchedRecipes.recipes.map { RecipeViewModel(recipe: $0) }
                return nil
            }
        }
        catch {
            return error as? FetchError
        }
        
        return nil
    }
}
