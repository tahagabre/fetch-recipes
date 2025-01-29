import SwiftUI

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
