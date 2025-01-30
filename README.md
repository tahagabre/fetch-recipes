# fetch-recipes
Recipe app for Fetch

### Summary: Include screen shots or a video of your app highlighting its features
* Fetch Recipes is an app designed around displaying a collection of recipes from all over the world. Users can filter by cuisine, look at the site that has the recipe, or watch a video of any recipe.


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
* Have the app look appealing. A great app that's ugly doesn't get used. The design is simple, uncluttered, and displays the information a user needs
* Have the app feel smooth. The feeling and functionality are usually coupled. A poor scroll both negatively affects the end user, and is indicative of an underlying issue with the code. But ultimately, we want the best user experience
* Allowing users to seamlessly adjust the view as needed. A user may land on the view and know they don't want British food. They should be able to get what they want in as little taps as possible.
* Code cleaniless. Having Views be as granualar as possible is a core principle of SwiftUI. Clean code means we can scale our project easier. Improvements and feature development is faster. New developers, or developers unfamiliar with your end of the codebase have less of a learning curve.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
* I spent about five hours on this project. My time was spent in even thirds, in this order:
    * Designing and implementing the UI. This included tweaks like rounding the image or adding thicker list separators. I pride myself in having a good eye for UX and design, and so I didn't want anyone to feel awkward using or looking at the app
    * User controls. This was mostly geared around adding filter buttons, favorite sliders, and links that push to Safari. Decisions had to be made in regard to how much of these controls I could allow with my time and technical constraints(see `Link` trade-off below for technical)
    * Performance tweaking, error states, and testing. This is where I adapted the list cell to cache images, only fetch images `onAppear`, added an error status to the home view and switched views based on that status, and unit tested. In regard to unit testing, I really looked for real world scenarios. I find unit tests to simply be a checkbox unless we apply them realisically, for example, a backend engineer changing the contract or a iOS dev removing a field they thought was not needed.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
* I opted to keep the design as clean as possible given the requirement constraints. Since I was allowed to only display a single view, I had to make the following decisions:
    * Display a source URL to the user if it exists. Technically, I could not find a way to have two `Link`s display in a view without the first taking priority. So I decided that if both exist, the source URL will take priority. If a source URL does not exist, the `Link` will be the video instead, if that exists.
    * Ideally, I would have had a modal presented when the user taps a cell. Inside the modal view would be a video player, the large image displayed, and maybe even suggestions for other recipes based on recipe data such as cuisine.
    
* Originally, I decided to use `AsyncImage` since it allowed for easy remote image loading and loading, failure, and success states with the `phase` parameter. However, I quickly realized with the network debugger that scrolling an image out of view and back in would actually fetch that remote image again. I decided to use my own `LazyImage`, where we networking from scratch and add the image to the cache. I made sure to only pull the image when the Image was in view. I know List has lazy loading functionality, but I saw a big performance buff when adding `onAppear` logic to the `LazyImage`.

* NetworkManager only has `static` functions. This is always a preference of mine, because it feels silly that any view, view model, or test would have to initialize or even worse, retain in memory, a NetworkManager to make a network call.

* For the purpose of:
    1. demonstrating my knowledge of API contracts
    2. how they implement in Swift, and
    3. fulfilling the requirement to throw away a response if any object inside is malformed,
I had the `RecipesResponse` and `RecipeResponse` have required and optional fields. However, I always prefer a gracious failure. In the case of a backend change, for example a required field comes back `nil`, I would like for my app to just not use that field. Of course, if I have control of the service I am consuming, like an orchestration layer, then I can use the typical pattern of required and optional fields.

* I always want to be on one screen as much as I can. If I have to enter modals to filter, sort, or favorite an item, I get frustrated. So, I made sure our filter buttons and favoriting sliders were easily accessible and followed one tap on/off states

### Weakest Part of the Project: What do you think is the weakest part of your project?
* Cold start up time can be poor. With more time, I would love to try paginating the response.
* Filtering is only by cuisine. Our endpoint gives a good amount of data that would allow us to filter by optional fields, such as if a recipe has a source url, a video url, or even by user actions such as favoriting. I would have loved to spend more time enabling those filters. In fact, you can see the ground work for that in the `Manager` class.
* Accessibility is not included here, but of course with more time I would have thrown in identifiers and tested that rigorously.
* If I had more time to refine the architecture, I would have the network layer deal with the image caching, as opposed to the images themselves. As mentioned above, I enjoy have a `static` network layer, but that doesn't do well to allow for an image cache that must be initialized and stored in memory.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
