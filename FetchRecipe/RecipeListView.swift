import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        VStack {
            if manager.recipes.isEmpty {
                ProgressView()
                    .navigationTitle(Text("Fetch Recipes"))
                    .progressViewStyle(.circular)
            }
            else {
                VStack {
                    Spacer()
                    FilterListView()
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 26))
                    List(manager.filteredRecipes, id: \.uuid) { recipe in
                        RecipeListCell(recipe: recipe)
                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    }
                    .scrollIndicators(.hidden)
                    .listRowSpacing(10)
                    .refreshable {
                        await fetchRecipes()
                    }
                }
                .navigationTitle(Text("Fetch Recipes"))
            }
        }
        .onAppear {
            Task {
                await fetchRecipes()
            }
        }
    }
    
    func fetchRecipes() async {
        do {
            let fetchedRecipes = try await NetworkManager.getRecipes()
            manager.recipes = fetchedRecipes.recipes.map { RecipeViewModel(recipe: $0) }
        }
        // TODO: Replacing view when error occurs
        catch {
//            switch error {
//            case .failedToGetData: Text("failed to get data")
//            case .invalidURL: Text("invalid url")
//            }
        }
    }
}
