//
//  SeriesCardTests.swift
//  MarvelSwiftUI
//
//  Created by Javier Muñoz on 22/12/24.
//

import SwiftUI
import Testing
@testable import MarvelSwiftUI

struct SeriesCardTests {

    @Suite("SeriesCard Testing")
    struct CardSuite {
        
        @Test("SeriesCard - Muestra contenido con datos completos")
        func seriesCardFullDataTest() async throws {
            // 1. Preparamos un MarvelSeries con todos los campos rellenos
            let thumbnail = MarvelSwiftUI.MarvelSeries.Thumbnail(
                path: "https://example.com/full-image",
                extension: "jpg"
            )
            
            let series = MarvelSwiftUI.MarvelSeries(
                id: 101,
                title: "Full Data Series",
                description: "Test description",
                startYear: 2021,
                endYear: 2022,
                rating: "PG-13",
                type: "Comic",
                thumbnail: thumbnail
            )
            
            // 2. Instanciamos la vista
            let card = SeriesCard(serie: series)
            
            // 3. Forzamos la evaluación del body (importante para coverage)
            _ = card.body
            
            // 4. Validamos que las computed properties devuelvan lo esperado
            #expect(card.descriptionText == "Test description",
                    "descriptionText debe coincidir con la descripción original")
            #expect(card.ratingText == "PG-13",
                    "ratingText debe coincidir con el rating original")
            #expect(card.typeText == "Comic",
                    "typeText debe coincidir con el type original")
        }
        
        @Test("SeriesCard - Campos vacíos o nulos devuelven '-'")
        func seriesCardEmptyDataTest() async throws {
            // 1. Preparamos un MarvelSeries con campos vacíos o nulos
            let thumbnail = MarvelSwiftUI.MarvelSeries.Thumbnail(
                path: "",
                extension: "png"
            )
            
            let series = MarvelSwiftUI.MarvelSeries(
                id: 202,
                title: "Empty Data Series",
                description: nil,  // descripción nula
                startYear: 0,
                endYear: 0,
                rating: "",        // rating vacío
                type: nil,         // type nulo
                thumbnail: thumbnail
            )
            
            // 2. Instanciamos la vista
            let card = SeriesCard(serie: series)
            
            // 3. Forzamos la evaluación del body
            _ = card.body
            
            // 4. Verificamos que las computed properties devuelvan el placeholder "-"
            #expect(card.descriptionText == "-",
                    "Si la descripción es nil o vacía, descriptionText debe ser '-'")
            #expect(card.ratingText == "-",
                    "Si la rating es nil o vacía, ratingText debe ser '-'")
            #expect(card.typeText == "-",
                    "Si el type es nil o vacío, typeText debe ser '-'")
        }
        
        @Test("SeriesCard - Maneja URL inválida o vacía en la imagen")
        func seriesCardInvalidURLTest() async throws {
            // 1. Preparamos un MarvelSeries con una URL “rota”
            let thumbnail = MarvelSwiftUI.MarvelSeries.Thumbnail(
                path: "  ",           // Espacios, simulando path no válido
                extension: "nope"     // Extensión dudosa
            )
            
            let series = MarvelSwiftUI.MarvelSeries(
                id: 303,
                title: "Broken Image Series",
                description: "Series with invalid thumbnail URL",
                startYear: 2023,
                endYear: 2024,
                rating: "R",
                type: "TV",
                thumbnail: thumbnail
            )
            
            // 2. Instanciamos la vista
            let card = SeriesCard(serie: series)
            
            // 3. Forzamos la evaluación del body
            _ = card.body
            
            // Aquí no hay un #expect directo para la imagen,
            // pero al menos forzamos esa rama de código en AsyncImage
            // donde el URL es inválido y se usa la imagen fallback.
            #expect(card.descriptionText == "Series with invalid thumbnail URL")
        }
    }
}
