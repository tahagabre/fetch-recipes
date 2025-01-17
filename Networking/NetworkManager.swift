import Foundation

enum FetchError: Error {
    case invalidURL
    case failedToGetData
}

class NetworkManager {
    
    static func getRecipes() async throws -> RecipesResponse {
        let path = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        guard let url = URL(string: path) else { throw FetchError.invalidURL }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            // TODO: use response to check for 200, else throw new error
            return try JSONDecoder().decode(RecipesResponse.self, from: data)
        }
        catch {
            throw FetchError.failedToGetData
        }
    }
    
//    static func getMalformedRecipes() {
//        
//    }
//    
//    static func getEmptyRecipes() {
//        
//    }
}
