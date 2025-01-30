# Fetch Recipes

Recipe app for Fetch

## Summary

Fetch Recipes is an app designed to showcase a diverse collection of recipes from around the world. Users can:

* Filter by cuisine
* Visit the source site for the recipe
* Watch a video tutorial for any recipe

### Screenshots
![IMG_7220](https://github.com/user-attachments/assets/b266d0b7-3b5c-4ba5-81f7-d3aade676604)
![IMG_7218](https://github.com/user-attachments/assets/9a7d12f5-4ba8-4510-840c-0e9b65be1c4b)![IMG_7219](https://github.com/user-attachments/assets/a0c3d64c-1405-4bf9-87af-4ce1c09f1492)

![IMG_7221](https://github.com/user-attachments/assets/819b96e9-450e-433a-ae53-e7e33020b19d)


## Focus Areas

* Have the app look appealing. No matter how great an app is, if it looks unappealing, users won't engage with it. The design is simple, uncluttered, and displays the information a user needs
  
* Have the app feel smooth. The feeling and functionality are usually coupled. Lack of fluidity not only affects the user experience but also signals potential underlying code issues
  
* Allow users to seamlessly adjust the view as needed. They should be able to find what they want in as few taps as possible
  
* Code cleanliness
   * Granular views, scalable project, faster improvements and feature development, little learning curve

## Time Spent

Total development time: ~5 hours

### UI Design & Implementation (1/3)

Focused on a polished look and feel

Tweaked UI (rounded images, thick list separators, etc.)

### User Controls (1/3)

Added filter buttons, favorite cell sliders, and external links

### Performance, Error Handling, and Testing (1/3)

Performance tweaking, error states, and testing

Only fetch images `onAppear`
  
Added error status and switched views based on that

Unit tested. Looked for real world scenarios, for example, a backend engineer changing the contract or an iOS developer removing a field they thought was not needed

## Trade-offs & Decisions 

### UI Constraints

Due to the requirement to display a single view, I prioritized showing a source URL if available

If both a source URL and video URL exist, the source URL takes precedence
  
Ideally, tapping a recipe would open a modal with a video player, a large image, and related suggestions based on cuisine

### Image Handling

Originally, I decided to use `AsyncImage` since it allowed for easy remote image loading and state handling with the `phase` parameter

However, I quickly realized with the network debugger that scrolling an image out and into view would actually fetch that remote image again

I decided to use my own `LazyImage`, where we handled networking from scratch and added the image to the cache

I made sure to only pull the image when the Image was in view. I know `List` has lazy loading functionality, but I saw a big performance boost when adding `onAppear` logic to the `LazyImage`

### Networking

NetworkManager only has `static` functions. This is always a preference of mine. Any view, view model, or test would not have to initialize or retain in memory a `NetworkManager` just to make a simple API call

I had the `RecipesResponse` and `RecipeResponse` have required and optional fields. I did this to:

* Demonstrate my knowledge of API contracts and how they are implemented in Swift
* Fulfill the requirement of throwing away a response if any object inside is malformed
    
However, I always prefer a gracious failure. Typically, I prefer making all `Codable` fields optional. If a backend change causes a required field to return `nil`, my approach ensures the app ignores the missing field rather than failing to load entirely

Of course, if I have control of the service I am consuming, like an orchestration layer, then I will use the typical pattern of required and optional fields

### User Interaction

Kept filtering and favoriting on the main screen for a seamless experience —- no unnecessary modals

## Weakest Areas

### Startup
Cold startup time can be poor. With more time, I would love to try paginating the response

### Filtering
Filtering is only by cuisine

Our endpoint gives a good amount of data that would allow us to filter by optional fields, such as if a recipe has a source url, a video url, or even by user actions such as favoriting.

I would have loved to spend more time enabling those filters.

In fact, you can see the ground work for that in the `Manager` class

### Accessibility
Accessibility is not currently included, but with more time, I would have added identifiers and tested it rigorously

### Architecture
If I had more time to refine the architecture, I would have handled image caching at the network layer instead of within the images themselves
As mentioned above, I enjoy having a `static` network layer, but that doesn't do well to allow for an image cache that must be initialized and stored in memory

