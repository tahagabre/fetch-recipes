import Foundation

enum FetchError: Error {
    case invalidURL
    case failedToGetData
    case emptyResponse
    case badData
    case fourHundredX // Anything that is a client error, for ex 404
    case fiveHundredX // Anything that is a server error, for ex 500
    case unknown
}

class NetworkManager {
    
    static func getRecipes() async throws -> RecipesResponse? {
        let path = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
//        let path = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
//        let path = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        guard let url = URL(string: path) else { throw FetchError.invalidURL }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...299:
                    let recipes = try JSONDecoder().decode(RecipesResponse.self, from: data)
                    if recipes.recipes.isEmpty { throw FetchError.emptyResponse }
                    else { return recipes }
                case 400...499:
                    throw FetchError.fourHundredX
                case 500...599:
                    throw FetchError.fiveHundredX
                default:
                    throw FetchError.unknown
                }
            }
            else {
                throw FetchError.failedToGetData
            }
        }
        catch {
            throw FetchError.badData
        }
    }
    
    static func getImage(urlString: String?) async throws -> Data {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            throw FetchError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        }
        catch {
            throw FetchError.badData
        }
        
    }
}
