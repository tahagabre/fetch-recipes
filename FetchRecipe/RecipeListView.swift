import SwiftUI

// TODO: Title
struct RecipeListView: View {
    @State var recipes: [RecipeViewModel] = []
    
    var body: some View {
        NavigationStack {
            if recipes.isEmpty {
                ProgressView()
                    .navigationTitle(Text("Fetch Recipes"))
            }
            else {
                VStack {
                    Spacer()
                    ScrollView(.horizontal) {
                        LazyHStack {
                            let cuisines = Array(Set(recipes.map { $0.cuisine })).sorted(by: <)
                            ForEach(cuisines, id: \.self) { cuisine in
                                Button(cuisine) {
                                    // TODO: get recipes to filter on tap
//                                    recipes.filter { $0 == cuisine }
                                }
                            }
                            Button("Has YouTube Video") {
                                
                            }
                            Button("Has Link") {
                                
                            }
                            Button("Favorites") {
                                
                            }
                        }
                        .frame(height: 30)
                    }
                    List(recipes, id: \.uuid) { recipe in
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
                    recipes = fetchedRecipes.recipes.map { RecipeViewModel(recipe: $0) }
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
