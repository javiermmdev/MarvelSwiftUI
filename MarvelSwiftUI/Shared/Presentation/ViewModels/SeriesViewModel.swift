import Foundation
@Observable
final class SeriesViewModel {
    // View state
    var status: Status = .none
    var series: [MarvelSeries] = []
    // Dependencies
    private let seriesUseCase: SeriesUseCaseProtocol
    private let heroID: Int
    
    /// Initializes the ViewModel with the use case and hero ID.
    ///
    /// - Parameters:
    ///   - heroID: The hero ID to filter series.
    ///   - seriesUseCase: The series use case (defaults to `SeriesUseCase()`).
    init(heroID: Int, seriesUseCase: SeriesUseCaseProtocol = SeriesUseCase()) {
        self.heroID = heroID
        self.seriesUseCase = seriesUseCase
        
        Task {
            await getSeries()
        }
    }
    /// Fetches the series related to the hero.
    @MainActor
    func getSeries() async {
        self.status = .loading
        
        guard let ts = SecureConstants.ts,
              let hash = SecureConstants.hashValue,
              let apiKey = SecureConstants.apiKey else {
            self.status = .error(error: "failedToDecryptAPIConstants")
            return
        }
        do {
            let fetchedSeries = try await seriesUseCase.getSeries(
                ts: ts,
                hash: hash,
                apikey: apiKey,
                characterID: heroID
            )
            self.series = fetchedSeries
            self.status = .loaded
        } catch {
            self.status = .error(error: "failedToFetchSeries \(error.localizedDescription)")
        }}}
