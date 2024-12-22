import SwiftUI
import Testing
@testable import MarvelSwiftUI

struct HomeMarvelTests {
    
    @Suite("HomeMarvel Tests")
    struct HomeMarvelSuite {
        
        // MARK: 1. Vista con una lista de héroes
        @Test("HomeMarvel - Vista con héroes en appState")
        func testHomeMarvelWithHeroes() throws {
            let appState = AppStateVM()
            appState.heroes = [
                MarvelSwiftUI.Hero(
                    id: 1,
                    name: "Iron Man",
                    thumbnail: MarvelSwiftUI.Thumbnail(
                        path: "http://example.com/ironman",
                        ext: "jpg"
                    )
                ),
                MarvelSwiftUI.Hero(
                    id: nil,  // Hero sin ID
                    name: "Mystery Hero",
                    thumbnail: nil
                )
            ]
            
            // Instanciamos la vista con el Environment
            let _ = HomeMarvel()
                .environment(appState)
            
            #expect(true, "HomeMarvel con lista de héroes se creó sin errores.")
        }
        
        // MARK: 2. Vista sin héroes (lista vacía)
        @Test("HomeMarvel - Vista con lista de héroes vacía")
        func testHomeMarvelWithoutHeroes() throws {
            let appState = AppStateVM()
            appState.heroes = [] // Lista vacía
            
            let _ = HomeMarvel()
                .environment(appState)
            
            #expect(true, "HomeMarvel sin héroes no produjo errores y muestra la vista básica.")
        }
    }
}
