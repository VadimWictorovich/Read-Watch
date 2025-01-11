//
//  APIModels.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 11.01.25.
//

import Foundation


// MARK: - Main Response
struct DocsResponse: Codable {
    let docs: [Doc]
    let total: Int?
    let limit: Int?
    let page: Int?
    let pages: Int?
}


// MARK: - Doc
struct Doc: Codable {
    let id: Int
    let name: String?
    let alternativeName: String?
    let enName: String?
    let type: String?
    let year: Int?
    let description: String?
    let shortDescription: String?
    let movieLength: Int?
    let names: [DocName]?
    let externalId: ExternalID?
    let logo: ImageURL?
    let poster: Poster?
    let backdrop: Backdrop?
    let rating: Rating?
    let votes: Votes?
    let genres: [Genre]?
    let countries: [Country]?
    let releaseYears: [ReleaseYear]?
    let isSeries: Bool?
    let ticketsOnSale: Bool?
    let totalSeriesLength: Int?
    let seriesLength: Int?
    let ratingMpaa: String?
    let ageRating: Int?
    let top10: Int?
    let top250: Int?
    let typeNumber: Int?
    let status: String?
}


// MARK: - Backdrop
struct Backdrop: Codable {
    let url: String?
    let previewUrl: String?
}


// MARK: - Country
struct Country: Codable {
    let name: String?
}


// MARK: - ExternalID
struct ExternalID: Codable {
    let kpHD: String?
    let imdb: String?
    let tmdb: Int?
}


// MARK: - Genre
struct Genre: Codable {
    let name: String?
}


// MARK: - ImageURL
struct ImageURL: Codable {
    let url: String?
}


// MARK: - DocName
struct DocName: Codable {
    let name: String?
    let language: String?
    let type: String?
}


// MARK: - Poster
struct Poster: Codable {
    let url: String?
    let previewUrl: String?
}


// MARK: - Rating
struct Rating: Codable {
    let kp: Double?
    let imdb: Double?
    let tmdb: Double?
    let filmCritics: Double?
    let russianFilmCritics: Double?
    let await: Double?
}


// MARK: - ReleaseYear
struct ReleaseYear: Codable {
    let start: Int?
    let end: Int?
}


// MARK: - Votes
struct Votes: Codable {
    let kp: String?
    let imdb: Int?
    let tmdb: Int?
    let filmCritics: Int?
    let russianFilmCritics: Int?
    let await: Int?
}


/*
 
 "docs": [
   {
     "id": 0,
     "name": "string",
     "alternativeName": "string",
     "enName": "string",
     "type": "string",
     "year": 0,
     "description": "string",
     "shortDescription": "string",
     "movieLength": 0,
     "names": [
       {
         "name": "string",
         "language": "string",
         "type": "string"
       }
     ],
     "externalId": {
       "kpHD": "48e8d0acb0f62d8585101798eaeceec5",
       "imdb": "tt0232500",
       "tmdb": 9799
     },
     "logo": {
       "url": "string"
     },
     "poster": {
       "url": "string",
       "previewUrl": "string"
     },
     "backdrop": {
       "url": "string",
       "previewUrl": "string"
     },
     "rating": {
       "kp": 6.2,
       "imdb": 8.4,
       "tmdb": 3.2,
       "filmCritics": 10,
       "russianFilmCritics": 5.1,
       "await": 6.1
     },
     "votes": {
       "kp": "60000",
       "imdb": 50000,
       "tmdb": 10000,
       "filmCritics": 10000,
       "russianFilmCritics": 4000,
       "await": 34000
     },
     "genres": [
       {
         "name": "string"
       }
     ],
     "countries": [
       {
         "name": "string"
       }
     ],
     "releaseYears": [
       {
         "start": 2022,
         "end": 2023
       }
     ],
     "isSeries": true,
     "ticketsOnSale": true,
     "totalSeriesLength": 0,
     "seriesLength": 0,
     "ratingMpaa": "string",
     "ageRating": 0,
     "top10": 0,
     "top250": 0,
     "typeNumber": 0,
     "status": "string"
   }
 ],
 "total": 0,
 "limit": 0,
 "page": 0,
 "pages": 0
}
 */
