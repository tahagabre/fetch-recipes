import SwiftUI

struct RecipeListCell: View {
    @State var recipe: RecipeViewModel?
    @EnvironmentObject var manager: Manager
    
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
            LazyImage(uuid: recipe?.uuid, url: recipe?.recipe.photo_url_small, image: UIImage(systemName: "photo")!)
        }
        .swipeActions {
            Button("Favorite", systemImage: "star", action: {
                recipe?.isFavorited.toggle()
            })
            .tint(.yellow)
        }
    }
}
