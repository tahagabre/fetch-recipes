import SwiftUI

struct LinkView: View {
    @State var url: URL
    @State var title: String
    @State var image: Image
    
    var body: some View {
        Link(destination: url) {
            Text(title)
                .multilineTextAlignment(.leading)
            image
        }
    }
}
