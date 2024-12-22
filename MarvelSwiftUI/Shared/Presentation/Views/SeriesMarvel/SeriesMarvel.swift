import SwiftUI

struct SeriesMarvel: View {
    @Environment(SeriesViewModel.self) var appState // Access the SeriesViewModel from the environment

    var body: some View {
        switch appState.status {
        case .none, .loading:
            // Display a loading indicator while fetching series
            ProgressView("loadingSeries")
                .progressViewStyle(CircularProgressViewStyle())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded:
            // Show the list of loaded series
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(appState.series, id: \.id) { series in
                        SeriesCard(serie: series) // Render each series using SeriesCard
                    }
                }
                .padding()
            }
        case .error(let errorMessage):
            // Present an error message if loading fails
            Text("Error: \(errorMessage)")
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

#Preview {
    let mockUseCase = SeriesUseCase(repo: DefaultSeriesRepositoryMock())
    let vm = SeriesViewModel(heroID: 1_011_334, seriesUseCase: mockUseCase)
    SeriesMarvel()
        .environment(vm)
}
