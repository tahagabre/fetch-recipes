import XCTest
@testable import FetchRecipe

final class FetchRecipeTests: XCTestCase {

    func dataFromJSONFile(path: String?) throws -> Data {
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else { throw FetchError.invalidURL }
        return try Data(contentsOf: url)
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Closest thing to a running app
    /// Could catch service changes, or if a dev marks an optional field as required
    func testRecipes() async throws {
        do {
            let response = try await NetworkManager.getRecipes()
            guard let resp = response else { throw FetchError.failedToGetData }
            XCTAssertFalse(resp.recipes.isEmpty)
        }
        catch {
            throw FetchError.badData
        }
    }
    
    /// Ensure
    func testDecodingGoodRecipes() throws {
        let data = try dataFromJSONFile(path: "recipes")
        let recipesResponse = try JSONDecoder().decode(RecipesResponse.self, from: data)
        
        XCTAssertNotNil(recipesResponse)
    }
    
    func testBadRecipes() async throws {
        let data = try dataFromJSONFile(path: "recipes-malformed")
        XCTAssertThrowsError(try JSONDecoder().decode(RecipesResponse.self, from: data))
    }

    func testEmptyRecipes() async throws {
        let data = try dataFromJSONFile(path: "recipes-empty")
        let responses = try JSONDecoder().decode(RecipesResponse.self, from: data)
        XCTAssertTrue(responses.recipes.isEmpty)
    }
    
    /// One instance of Recipe
    func testRecipeEncodingDecoding() throws {
        let recipe = RecipeResponse(
            cuisine: "Italian",
            name: "Budino Di Ricotta",
            uuid: "563dbb27-5323-443c-b30c-c221ae598568",
            photo_url_large: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/2cac06b3-002e-4df7-bb08-e15bbc7e552d/large.jpg",
            photo_url_small: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/2cac06b3-002e-4df7-bb08-e15bbc7e552d/small.jpg",
            source_url: "https://thehappyfoodie.co.uk/recipes/ricotta-cake-budino-di-ricotta",
            youtube_url: "https://www.youtube.com/watch?v=6dzd6Ra6sb4"
        )

        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        let data = try encoder.encode(recipe)
        let decodedRecipe = try decoder.decode(RecipeResponse.self, from: data)

        XCTAssertEqual(recipe, decodedRecipe)
    }

    /// Array of Recipes
    func testRecipesEncodingDecoding() throws {
        let recipesResponse = RecipesResponse(recipes: [
            RecipeResponse(
                cuisine: "Italian",
                name: "Budino Di Ricotta",
                uuid: "563dbb27-5323-443c-b30c-c221ae598568",
                photo_url_large: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/2cac06b3-002e-4df7-bb08-e15bbc7e552d/large.jpg",
                photo_url_small: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/2cac06b3-002e-4df7-bb08-e15bbc7e552d/small.jpg",
                source_url: "https://thehappyfoodie.co.uk/recipes/ricotta-cake-budino-di-ricotta",
                youtube_url: "https://www.youtube.com/watch?v=6dzd6Ra6sb4"
            ),
            RecipeResponse(
                cuisine: "British",
                name: "Eton Mess",
                uuid: "1a86ef7d-a9f1-44c1-a4a0-2278f5916d49",
                photo_url_large: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/258262f1-57dc-4895-8856-bf95aee43054/large.jpg",
                photo_url_small: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/258262f1-57dc-4895-8856-bf95aee43054/small.jpg",
                source_url: nil,
                youtube_url: "https://www.youtube.com/watch?v=43WgiNq54L8"
            )
        ])
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let data = try encoder.encode(recipesResponse)
        let decodedResponse = try decoder.decode(RecipesResponse.self, from: data)
        
        XCTAssertEqual(recipesResponse.recipes, decodedResponse.recipes)
    }

}
