import SwiftUI

struct FilterListView: View {
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(manager.cuisines, id: \.self) { cuisine in
                        SelectableFilterButton(title: cuisine) {
                            manager.appliedFilters.contains(cuisine) ? manager.appliedFilters.removeAll(where: {$0 == cuisine}) : manager.appliedFilters.append(cuisine)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
