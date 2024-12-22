//
//  DefaultSeriesRepositoryMockTests.swift
//  MarvelSwiftUI
//
//  Created by Javier Muñoz on 22/12/24.
//


import Foundation
import Testing
@testable import MarvelSwiftUI

struct DefaultSeriesRepositoryMockTests {

    @Suite("DefaultSeriesRepositoryMock Testing")
    struct RepositoryMockTest {

        @Test("DefaultSeriesRepositoryMock - Retorna la lista mock de series")
        func testDefaultSeriesRepositoryMock() async throws {
            // DADO: un DefaultSeriesRepositoryMock (que internamente usa NetworkSeriesMock)
            let mockRepository = DefaultSeriesRepositoryMock()

            // CUANDO: se llama al método getSeries con cualquier parámetro
            let series = try await mockRepository.getSeries(
                ts: "tsValue",
                hash: "hashValue",
                apikey: "apiKey",
                characterID: 12345
            )

            // ENTONCES: Verificamos que sea la misma lista que define NetworkSeriesMock
            #expect(series.count == 2, "El mock debería retornar 2 series de prueba.")

            // Verificamos la primera serie
            #expect(series[0].id == 6381)
            #expect(series[0].title == "Ender's Shadow: Battle School (2008 - 2009)")
            #expect(series[0].description == "A strategic battle school scenario featuring Ender Wiggin.")
            #expect(series[0].startYear == 2008)
            #expect(series[0].endYear == 2009)
            #expect(series[0].rating == "5 Stars")
            #expect(series[0].type == "Action")
            #expect(series[0].thumbnail.path == "http://i.annihil.us/u/prod/marvel/i/mg/c/10/4bb64aaaa9755")
            #expect(series[0].thumbnail.extension == "jpg")

            // Verificamos la segunda serie
            #expect(series[1].id == 7743)
            #expect(series[1].title == "Enders Shadow: Command School (2009 - 2010)")
            #expect(series[1].description == "Ender Wiggin moves into the command phases of his training.")
            #expect(series[1].startYear == 2009)
            #expect(series[1].endYear == 2010)
            #expect(series[1].rating == "")
            #expect(series[1].type == "")
            #expect(series[1].thumbnail.path == "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available")
            #expect(series[1].thumbnail.extension == "jpg")
        }
    }
}