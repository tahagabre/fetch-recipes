//
//  SwiftUIView.swift
//  FetchRecipe
//
//  Created by Taha Gabre on 1/25/25.
//

import SwiftUI
import SwiftUI
import Combine

class ManagerPlaceholder: ObservableObject {
    
    @Published var propertyOne: Double = 1.0
    @Published var propertyTwo: Double = 2.0
    
    func action() {
        propertyOne = Double.random(in: 0.0..<100.00)
        propertyTwo = Double.random(in: 0.0..<100.00)
    }
    
}


struct PlaygroundView: View {
    
    @EnvironmentObject var manager: ManagerPlaceholder
    
    var body: some View {
        TabView {
            Subview()
                .tabItem { Label("First", systemImage: "hexagon.fill") }
                .tag(1)
            Subview()
                .tabItem { Label("Second", systemImage: "circle.fill") }
                .tag(2)
            
        }
    }
    
}

struct Subview: View {
    
    @EnvironmentObject var manager: ManagerPlaceholder
    
    var body: some View {
        VStack {
            Text("Prop One: \(manager.propertyOne)").padding()
            Text("Prop Two: \(manager.propertyTwo)").padding()
            Button("Change", action: manager.action).padding()
        }
    }
    
}
