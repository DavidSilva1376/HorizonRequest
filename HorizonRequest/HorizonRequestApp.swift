import SwiftUI

@main
struct Horizon_RequestApp: App {
    @StateObject var currentUser = CurrentUser()
    @StateObject var feedViewModel = FeedViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LoginView()
            }
            .environmentObject(currentUser)
            .environmentObject(feedViewModel)
        }
    }
}
