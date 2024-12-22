//
//  DefaultHeroesRepositoryMockTests.swift
//  MarvelSwiftUI
//
//  Created by Javier Muñoz on 22/12/24.
//


import Foundation
import Testing
@testable import MarvelSwiftUI

struct DefaultHeroesRepositoryMockTests {

    @Suite("DefaultHeroesRepositoryMock Testing")
    struct RepositoryMockTest {

        @Test("DefaultHeroesRepositoryMock - Devuelve la lista mock de héroes")
        func testDefaultHeroesRepositoryMock() async throws {
            // DADO: un DefaultHeroesRepositoryMock (que internamente usa NetworkHeroesMock)
            let mockRepository = DefaultHeroesRepositoryMock()

            // CUANDO: Se llama al método getHeroes con cualquier parámetro
            let heroes = try await mockRepository.getHeroes(
                ts: "testTs",
                hash: "testHash",
                apikey: "testApiKey",
                orderBy: "name"
            )

            // ENTONCES: Verificamos que sean los mismos héroes que definimos en NetworkHeroesMock
            #expect(heroes.count == 2, "El mock debería retornar 2 héroes de prueba.")

            // Primer héroe
            #expect(heroes[0].id == 1)
            #expect(heroes[0].name == "Iron Man")
            #expect(heroes[0].thumbnail != nil)
            #expect(heroes[0].thumbnailURL.contains("Iron_Man_Vol_7_1_Negative_Space_Variant.jpg"))

            // Segundo héroe
            #expect(heroes[1].id == 2)
            #expect(heroes[1].name == "Spider-Man")
            #expect(heroes[1].thumbnail != nil)
            #expect(heroes[1].thumbnailURL.contains("Amazing_Spider-Man_Vol_5_15_Textless.jpg"))
        }
    }
}