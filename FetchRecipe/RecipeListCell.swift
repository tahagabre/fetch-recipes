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
                NonSelectableFilterButton(title: recipe?.cuisine ?? "")
                Spacer()
                if let source = recipe?.sourceUrl {
                    LinkView(url: source, title: "Visit Site", image: Image(systemName: "safari.fill"))
                    Spacer()
                }
                else if let video = recipe?.videoURL {
                    LinkView(url: video, title: "Watch Video", image: Image(systemName: "video.circle.fill"))
                }
            }
            Spacer(minLength: 50)
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
