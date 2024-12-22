import Foundation
import Combine

/// ViewModel responsible for managing the application's state.
@Observable
final class AppStateVM {
    // Published properties to notify views of changes
    var status: Status = .none // Current status of the lifecycle
    var heroes: [Hero] = [] // List of heroes
    
    // Dependency for fetching heroes
    private var heroesUseCase: HeroesUserCaseProtocol
    
    /// Initializes the AppStateVM with the Heroes use case.
    ///
    /// - Parameter heroesUseCase: The use case implementing `HeroesUserCaseProtocol`.
    ///   Defaults to the `HeroesUseCase` implementation.
    init(heroesUseCase: HeroesUserCaseProtocol = HeroesUserCase()) {
        self.heroesUseCase = heroesUseCase
        Task {
            await getHeroes()
        }
    }
    
    /// Fetches heroes from the Marvel API and updates the state.
    @MainActor
    func getHeroes() async {
        // Indicate that data fetching has started
        self.status = .loading
        
        // Retrieve necessary API parameters securely
        guard let ts = SecureConstants.ts,
              let hash = SecureConstants.hashValue,
              let apiKey = SecureConstants.apiKey else {
            self.status = .error(error: "failedToDecryptAPIConstants")
            return
        }
        
        // Execute the network request asynchronously
        Task {
            do {
                let fetchedHeroes = try await heroesUseCase.getHeroes(
                    ts: ts,
                    hash: hash,
                    apikey: apiKey,
                    orderBy: HTTPSMethods.ORDER_BY
                )
                
                // Update the heroes list and status upon successful fetch
                self.heroes = fetchedHeroes
                self.status = .loaded
            } catch {
                // Handle any errors that occur during the fetch
                self.status = .error(error: "failedToFetchHeroes \(error.localizedDescription)")
            }
        }
    }
}
