import Foundation
import Testing
@testable import MarvelSwiftUI

struct MarvelSeriesTests {

    @Suite("Marvel Series Testing")
    struct SeriesSuite {
        
        @Test("MarvelSeries - Test de init y propiedades")
        func marvelSeriesBasicTest() async throws {
            let thumbnail = MarvelSwiftUI.MarvelSeries.Thumbnail(
                path: "https://example.com/series",
                extension: "jpg"
            )
            
            let series = MarvelSwiftUI.MarvelSeries(
                id: 200,
                title: "My Awesome Series",
                description: "A brand new Marvel series to test",
                startYear: 2020,
                endYear: 2021,
                rating: "PG-13",
                type: "Comic",
                thumbnail: thumbnail
            )
            
            #expect(series.id == 200)
            #expect(series.title == "My Awesome Series")
            #expect(series.description == "A brand new Marvel series to test")
            #expect(series.startYear == 2020)
            #expect(series.endYear == 2021)
            #expect(series.rating == "PG-13")
            #expect(series.type == "Comic")
            
            #expect(series.thumbnail.path == "https://example.com/series")
            #expect(series.thumbnail.extension == "jpg")
        }
        
        @Test("MarvelSeries - Decodifica JSON con descripción nula correctamente")
        func marvelSeriesNilDescriptionTest() async throws {
            let json = """
            {
                "id": 201,
                "title": "Series Without Description",
                "startYear": 2022,
                "endYear": 2023,
                "rating": "PG",
                "type": "TV",
                "thumbnail": {
                    "path": "https://example.com/seriesimg",
                    "extension": "png"
                }
            }
            """.data(using: .utf8)!
            
            let decoded = try JSONDecoder().decode(MarvelSwiftUI.MarvelSeries.self, from: json)
            #expect(decoded.id == 201)
            #expect(decoded.title == "Series Without Description")
            #expect(decoded.description == nil, "La descripción debería ser nil si no vino en el JSON")
            #expect(decoded.startYear == 2022)
            #expect(decoded.endYear == 2023)
            #expect(decoded.rating == "PG")
            #expect(decoded.type == "TV")
            
            #expect(decoded.thumbnail.path == "https://example.com/seriesimg")
            #expect(decoded.thumbnail.extension == "png")
        }
        
        @Test("MarvelSeriesResponse - Decodifica JSON completo correctamente")
        func marvelSeriesResponseDecodeTest() async throws {
            let json = """
            {
                "code": 200,
                "status": "Ok",
                "data": {
                    "results": [
                        {
                            "id": 999,
                            "title": "Ultimate Series",
                            "description": "Some epic Marvel series",
                            "startYear": 2019,
                            "endYear": 2020,
                            "rating": "R",
                            "type": "Comic",
                            "thumbnail": {
                                "path": "https://example.com/ultimate",
                                "extension": "jpg"
                            }
                        }
                    ]
                }
            }
            """.data(using: .utf8)!
            
            let decoded = try JSONDecoder().decode(MarvelSeriesResponse.self, from: json)
            #expect(decoded.code == 200)
            #expect(decoded.status == "Ok")
            #expect(decoded.data.results.count == 1)
            
            let series = decoded.data.results.first!
            #expect(series.id == 999)
            #expect(series.title == "Ultimate Series")
            #expect(series.description == "Some epic Marvel series")
            #expect(series.startYear == 2019)
            #expect(series.endYear == 2020)
            #expect(series.rating == "R")
            #expect(series.type == "Comic")
            #expect(series.thumbnail.path == "https://example.com/ultimate")
            #expect(series.thumbnail.extension == "jpg")
        }
    }
}
