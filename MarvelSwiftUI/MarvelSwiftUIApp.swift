import SwiftUI

@main
struct MarvelSwiftUIApp: App {
    @State var AppState = AppStateVM() // Initialize the application's state view model
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(AppState) // Inject the AppState into the environment for child views
        }
    }
}
