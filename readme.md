# Marvel - Dom Bryan
The Marvel application pulled a list of comics from their public API, this was handled by the Marvel Service along with the MarvelImageService for downloading and caching images. Both of these services are underlaid by the NetworkManager. By separating the manager and the services out into their own classes, I was able to test each part individually, mocking a network manager for the service tests, and URL session for the network manager.

A coordinator pattern was used to launch the application into the Home controller and then segue to a detail view. The use of the coordinator pattern also pathed the way for easier testing through the concept of single responsibility, and injecting in view models required for their respective controllers.

Finally the home controller makes use of iOS13s ability to add a search controller to a navigation bar and display those results to a table view. In both the Home controller and detail controller, a view model was used in order to remove complexities from the controllers and allow for better future testing.

## Things I’d do with more time:
- Ideally separating out the view components more from the Home controller similar to the detail controller, which simply overrides the load view method and passes in a custom view.
- Extract table view datasource into its own class.
- More unit testing and the addition of XCUI testing for flow tests (However this is partly covered by the coordinator unit tests).
- Better handling of dark mode.
- Issue with testing image cache service: Not able to obtain image from bundle.
- A slightly prettier detail view.
