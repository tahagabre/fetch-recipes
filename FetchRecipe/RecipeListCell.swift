import SwiftUI

struct RecipeListCell: View {
    @State var recipe: RecipeViewModel?
    
    var body: some View {
        HStack {
            VStack {
                Text(recipe?.name ?? "")
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                NonSelectableFilterButton(title: recipe?.cuisine ?? "", action: {})
                Spacer()
                if let source = recipe?.sourceUrl {
                    Link(destination: source) {
                        HStack {
                            Text("Visit site")
                                .multilineTextAlignment(.leading)
                            Image(systemName: "safari.fill")
                        }
                    }
                    Spacer()
                }
                else if let video = recipe?.videoURL {
                    Link(destination: video) {
                        HStack {
                            Text("Watch video")
                                .multilineTextAlignment(.leading)
                            Image(systemName: "video.circle.fill")
                        }
                    }
                }
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
                        .frame(width: 150)
                default:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .swipeActions {
            Button("Favorite", systemImage: "star", action: {
                recipe?.isFavorited.toggle()
            })
            .tint(.yellow)
        }
    }
}

//struct RecipeSiteLink
//
//struct RecipeVideoLink
