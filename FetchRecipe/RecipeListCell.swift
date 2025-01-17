import SwiftUI

struct RecipeListCell: View {
    @State var recipe: RecipeViewModel?
    
    var body: some View {
        LazyVStack {
            // TODO: stub out image
            AsyncImage(url: recipe?.smallPhotoURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .success(let image):
                    image
                        .scaledToFill()
                        .clipped()
                default:
                    Image(systemName: "photo")
                }
            }
            Spacer()
            HStack {
                Text(recipe?.name ?? "")
                Spacer()
                Image(systemName: "star")
            }
        }
    }
}
