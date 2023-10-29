import SwiftUI
import Network

class NetworkManager: ObservableObject {
    @Published var isInternetConnected = true
    @Published var isRestored = false

    private let monitor = NWPathMonitor()

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                let isConnected = path.status == .satisfied
                if !self!.isInternetConnected && isConnected {
                    // Internet connection is restored
                    withAnimation {
                        self?.isRestored = true
                    }
                    
                    // Set a timer to reset isRestored to false after a delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            self?.isRestored = false
                        }
                    }
                }
                self?.isInternetConnected = isConnected
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}

@main
struct YourApp: App {
    @StateObject var networkManager = NetworkManager()

    var body: some Scene {
        WindowGroup {
            ContentView(networkManager: networkManager)
        }
    }
}

struct ContentView: View {
    @ObservedObject var networkManager: NetworkManager

    var body: some View {
        if networkManager.isInternetConnected {
            if networkManager.isRestored {
                VStack {
                    Text("Network secured, welcome back!")
                        .padding()
                }
            } else {
                Text("Hello, this is peace, follow me at")
                    .padding()
                Link("https://twitter.com/PEACEE0907", destination: URL(string: "https://twitter.com/PEACEE0907")!)
            }
        } else {
            VStack {
                Text("Oops... seems like you are disconnected")
                    .padding()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
            }
        }
    }
}
