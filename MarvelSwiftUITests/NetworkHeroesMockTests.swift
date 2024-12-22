//
//  NetworkHeroesMockTests.swift
//  MarvelSwiftUI
//
//  Created by Javier Muñoz on 22/12/24.
//


import Foundation
import Testing
@testable import MarvelSwiftUI

struct NetworkHeroesMockTests {

    @Suite("Network Mock Testing")
    struct NetworkMockTest {

        @Test("NetworkHeroesMock - Retorna la lista de héroes predefinida")
        func testMockReturnsPredefinedHeroes() async throws {
            // Dado: un Mock de NetworkHeroes
            let mock = NetworkHeroesMock()

            // Cuando: se llama a getHeroes con parámetros genéricos
            let heroes = try await mock.getHeroes(
                ts: "testTs",
                hash: "testHash",
                apikey: "testApiKey",
                orderBy: "name"
            )

            // Entonces: verificamos que los héroes sean exactamente los que el Mock define
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