import Foundation

class NetworkManager {
    static func getRecipes(onSuccess: @escaping (RecipesResponse) -> (), onError: @escaping ((Error) -> ())) {
        let path = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        guard let url = URL(string: path) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let recipesResponse = try JSONDecoder().decode(RecipesResponse.self, from: data)
                onSuccess(recipesResponse)
            }
            catch {
                onError(error)
            }
        }.resume()
    }
    
//    static func getMalformedRecipes() {
//        
//    }
//    
//    static func getEmptyRecipes() {
//        
//    }
}
