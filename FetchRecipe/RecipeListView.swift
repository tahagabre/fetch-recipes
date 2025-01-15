//
//  ContentView.swift
//  FetchRecipe
//
//  Created by Taha Gabre on 1/14/25.
//

import SwiftUI

// TODO: Title
struct RecipeListView: View {
    @State var recipes: [RecipeViewModel] = []
    
    var body: some View {
        List(recipes, id: \.uuid) { recipe in
            Text(recipe.name)
        }
        .onAppear {
            // TODO: Loading wheel
            NetworkManager.getRecipes { resp in
                resp.recipes.forEach { recipe in
                    recipes.append( RecipeViewModel(recipe: recipe) )
                }
            } onError: { error in
                // TODO: Error state
                print(error)
            }
        }
    }
}
