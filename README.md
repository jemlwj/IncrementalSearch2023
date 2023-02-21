# Incremental Search 2023
#### by Jeremy Lua
This project accesses GitHub's repository search API and return the repository name and URL in a List.

Developed in Swift and SwiftUI and uses Combine for the API request.
Unit Test of the model and the data source class is also implemented.

## Development Environment
* macOS Catalina 10.15.1
* Xcode 11.2.1

## How to use

1. Tap on the text field at the top of the screen which states "Enter search query"
2. Enter desired keyword
3. Tap Enter/Return on the keyboard
4. the first page of the results will return
5. scroll to the end of the page to load more results into the list.

## API Throttling

As the GitHub API limits requests from non-authenticated source to 10 per every minute, the rate of API requests is limited.
This will be caught as an error within API Request call.

However, the app will handle this by not allowing the web request to be called within a 5-second window.
Any additional API requests within the 5-second window will be returned a error popup stating the API Throttling.

## Error Handling
Below errors are handled explcitly in the project

403: API Rate Limit Error
-1002: Unsupported URL
-1009: Network offline
