import SwiftUI

struct RecipeListCell: View {
    @State var recipe: RecipeViewModel?
    
    var body: some View {
        HStack {
            VStack {
                Text(recipe!.name)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                NonSelectableFilterButton(title: recipe?.cuisine ?? "", action: {})
            }
            Spacer(minLength: 10)
            AsyncImage(url: recipe?.smallPhotoURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                default:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            Spacer(minLength: 10)
            Image(systemName: "chevron.right")
                .frame(alignment: .trailing)
        }
        .swipeActions {
            Button("Favorite", systemImage: "star", action: {
                recipe?.isFavorited.toggle()
            })
            .tint(.yellow)
        }
    }
}
