import SwiftUI

struct SelectableFilterButton: View {
    @State var isSelected = false
    @State var title: String
    @State var action: () -> ()
    
    var body: some View {
        Button(title) {
            action()
            isSelected.toggle()
        }
        .lineLimit(0)
        .frame(height: 2, alignment: .leading)
        .padding()
        .background(Color(.lightGray))
        .foregroundStyle(.black)
        .clipShape(.capsule)
        .opacity(isSelected ? 1 : 0.5)
        .animation(.easeInOut, value: isSelected)
    }
}

struct NonSelectableFilterButton: View {
    @State var title: String
    
    var body: some View {
        Button(title) {}
        .lineLimit(0)
        .frame(width: 80, height: 2, alignment: .center)
        .padding()
        .background(Color(.lightGray))
        .foregroundStyle(.black)
        .clipShape(.capsule)
        .opacity(0.5)
    }
}
