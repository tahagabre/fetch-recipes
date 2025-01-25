import SwiftUI

struct FilterListView: View {
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(manager.cuisineList, id: \.self) { cuisine in
                    Button(cuisine) {
                        manager.appliedFilters.contains(cuisine) ? manager.appliedFilters.removeAll(where: {$0 == cuisine}) : manager.appliedFilters.append(cuisine)
                    }
                }
                Button("Has YouTube Video") {
                    
                }
                Button("Has Web Link") {
                    
                }
                Button("Favorites") {
                    
                }
            }
            .frame(height: 30)
        }
    }
}
