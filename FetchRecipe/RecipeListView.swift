import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject var manager: Manager
    
    var body: some View {
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
        }
    }
}
