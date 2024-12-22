import SwiftUI

struct RootView: View {
    @Environment(AppStateVM.self) var appState // Access the application's state from the environment
       
    var body: some View {
        switch appState.status {
        case .none:
            // Display the error view when no status is set
            AppLoadErrorView()
                .transition(.opacity)
                .animation(.easeInOut, value: appState.status)
                
        case .loaded:
            // Show the main content when data is loaded
            HomeMarvel()
                .transition(.slide)
                .animation(.easeInOut, value: appState.status)
                
        case .loading:
            // Present a loading indicator while data is being fetched
            ProgressView("loading")
                .progressViewStyle(CircularProgressViewStyle())
                .font(.headline)
                .foregroundStyle(.blue)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.opacity)
                .animation(.easeInOut, value: appState.status)
                
        case .error(error: let errorString):
            // Show the error view with a specific error message
            AppLoadErrorView(errorMessage: errorString)
                .transition(.opacity)
                .animation(.easeInOut, value: appState.status)
        }
    }
}

#Preview {
    RootView()
        .environment(AppStateVM())
}
