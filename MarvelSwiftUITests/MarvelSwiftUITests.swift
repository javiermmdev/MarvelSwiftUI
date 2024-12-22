import Foundation
import Testing
@testable import MarvelSwiftUI

struct MarvelSwiftUITests {
    
    @Suite("Domain Testing")
    struct DomainTest {
        
        @Suite("Entidades", .serialized)
        struct ModelTest {
            
            // MARK: - Tests previos de Hero, Thumbnail, etc.
            @Test("Hero Model - Test Bueno")
            func heroModelGoodTest() async throws {
                let thumbnail = Thumbnail(path: "https://example.com/image", ext: "jpg")
                let hero = Hero(id: 101, name: "Iron Man", thumbnail: thumbnail)
                
                #expect(hero.id == 101)
                #expect(hero.name == "Iron Man")
                
                #expect(hero.thumbnail != nil)
                #expect(hero.thumbnail?.path == "https://example.com/image")
                #expect(hero.thumbnail?.ext == "jpg")
                
                // Verificamos la URL construida
                #expect(hero.thumbnailURL == "https://example.com/image.jpg")
            }
            
            @Test("Hero Model - Verifica error si no existe ID requerido")
            func heroModelIDMissingTest() async throws {
                do {
                    let hero = Hero(id: nil, name: "Fake Hero", thumbnail: nil)
                    try validateRequiredID(in: hero)
                    #expect(Bool(false), "Se esperaba un error al no traer ID, pero no se produjo ningún error.")
                } catch let error as NSError {
                    #expect(error.domain == "HeroTestError",
                            "Se esperaba un domain de error 'HeroTestError', pero se obtuvo \(error.domain)")
                    #expect(error.code == 100,
                            "Se esperaba el código de error 100 para 'ID requerido' pero se obtuvo \(error.code)")
                }
            }
            
            private func validateRequiredID(in hero: Hero) throws {
                guard hero.id != nil else {
                    throw NSError(
                        domain: "HeroTestError",
                        code: 100,
                        userInfo: [
                            NSLocalizedDescriptionKey: "El ID del Hero es requerido y no llegó"
                        ]
                    )
                }
            }
            
            @Test("Thumbnail - Válido (path y ext presentes)")
            func thumbnailValidTest() async throws {
                let thumbnail = Thumbnail(path: "https://example.com/myhero", ext: "png")
                #expect(thumbnail.path == "https://example.com/myhero")
                #expect(thumbnail.ext == "png")
                #expect(thumbnail.fullImageURL == "https://example.com/myhero.png")
            }
            
            @Test("Thumbnail - Faltan datos (path o ext nulos)")
            func thumbnailMissingDataTest() async throws {
                let thumbnail1 = Thumbnail(path: nil, ext: "jpg")
                #expect(thumbnail1.fullImageURL == nil, "Si path es nil, fullImageURL debe ser nil")
                
                let thumbnail2 = Thumbnail(path: "https://example.com/img", ext: nil)
                #expect(thumbnail2.fullImageURL == nil, "Si ext es nil, fullImageURL debe ser nil")
            }
            
            @Test("Hero - thumbnailURL vacío cuando thumbnail es nil")
            func heroThumbnailNilTest() async throws {
                let hero = Hero(id: 999, name: "NilHero", thumbnail: nil)
                #expect(hero.thumbnail == nil)
                #expect(hero.thumbnailURL.isEmpty, "Si thumbnail es nil, thumbnailURL debe ser ''.")
            }
            
        }
    }
}
