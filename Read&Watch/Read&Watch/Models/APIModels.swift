//
//  APIModels.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 11.01.25.
//

import Foundation

// MARK: - MOVIES
// Main Response
struct DocsResponse: Codable {
    let docs: [Doc]
    let total: Int?
    let limit: Int?
    let page: Int?
    let pages: Int?
}


// Doc
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


// Backdrop
struct Backdrop: Codable {
    let url: String?
    let previewUrl: String?
}


// Country
struct Country: Codable {
    let name: String?
}


// ExternalID
struct ExternalID: Codable {
    let kpHD: String?
    let imdb: String?
    let tmdb: Int?
}


// Genre
struct Genre: Codable {
    let name: String?
}


// ImageURL
struct ImageURL: Codable {
    let url: String?
}


// DocName
struct DocName: Codable {
    let name: String?
    let language: String?
    let type: String?
}


// Poster
struct Poster: Codable {
    let url: String?
    let previewUrl: String?
}


// Rating
struct Rating: Codable {
    let kp: Double?
    let imdb: Double?
    let tmdb: Double?
    let filmCritics: Double?
    let russianFilmCritics: Double?
    let await: Double?
}


// ReleaseYear
struct ReleaseYear: Codable {
    let start: Int?
    let end: Int?
}


// Votes
struct Votes: Codable {
    let kp: Int?
    let imdb: Int?
    let tmdb: Int?
    let filmCritics: Int?
    let russianFilmCritics: Int?
    let await: Int?
}


// MARK: - BOOK
// Главный ответ от Google Books API
struct GoogleBooksResponse: Codable {
    let totalItems: Int
    let items: [Item]?
}

// Отдельная структура для элемента книги
struct Item: Codable {
    let id: String
    let volumeInfo: VolumeInfo
}

// Информация о книге
struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let imageLinks: ImageLinks?
    let previewLink: String?
}

// Информация о ссылках на изображения книги
struct ImageLinks: Codable {
    let thumbnail: String?
}

