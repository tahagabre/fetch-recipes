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

struct LazyImage: View {
    @EnvironmentObject var manager: Manager
    @State var uuid: String?
    @State var url: String?
    @State var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 150)
            .onAppear {
                Task {
                    await fetchImage()
                }
            }
    }
    
    private func fetchImage() async {
        if let cachedImageData = manager.imageCache.retrieve(key: uuid),
           let cachedImage = UIImage(data: cachedImageData as Data) {
            image = cachedImage
            return
        }
        
        do {
            let imageData = try await NetworkManager.getImage(urlString: url)
            if let uiImage = UIImage(data: imageData), let id = uuid {
                image = uiImage
                manager.imageCache.set(key: id, data: imageData as NSData)
            }
        }
        catch {}
    }
}
