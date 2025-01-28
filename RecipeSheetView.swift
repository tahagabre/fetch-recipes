import SwiftUI
import AVKit

// TODO: push to view. We want to see title, cuisine, link, palyable video, large image
struct RecipeSheetView: View {
    @State var recipe: RecipeViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Text(recipe.name)
                    .font(.largeTitle)
                Image(systemName: "star") // fill if isFavorited
            }
            
            AsyncImage(url: recipe.largePhotoURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                default:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}
