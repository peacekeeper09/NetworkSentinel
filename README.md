# NetworkSentinel

## Working

`NetworkManager` is a class that conforms to the ObservableObject protocol, making it observable for SwiftUI views. It has two published properties: `isInternetConnected` to track the internet connection status and `isRestored` to indicate if the connection has been restored.https://github.com/PRATIKK0709/NetworkSentinel/blob/main/README.md

`NWPathMonitor` is used to monitor network path changes. It checks if the connection status is "satisfied" (i.e., there's an active internet connection) and updates the isInternetConnected property accordingly. If the connection was restored after a period of disconnection, it sets isRestored to true and then uses a timer to reset it to false after 3 seconds.


`YourApp` is the main app entry point, and it creates an instance of NetworkManager as a @StateObject to manage the network status throughout the app.

`ContentView` is a SwiftUI view that uses the networkManager instance to display different content based on the network status. It checks if the internet connection is available, and if it is, it displays a welcome message, indicating that the network is restored, or a link to follow, depending on the isRestored property. If the internet connection is not available, it shows an error message and a progress view.

## Screenshots
