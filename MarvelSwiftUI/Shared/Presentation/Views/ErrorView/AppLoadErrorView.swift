import SwiftUI

struct AppLoadErrorView: View {
    var errorMessage: String?

    var body: some View {
        VStack(spacing: 24) {
            // Display the hero error image
            Image(.heroError)
                .resizable()
                .scaledToFit()
                .frame(width: 240, height: 240)
                .padding(.top, 40)

            // Show the main error message
            Text("appLoadFailure")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            // Display a secondary error message if available
            if let error = errorMessage {
                Text(error)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            } else {
                Text("pleaseTryLater")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    AppLoadErrorView()
}
