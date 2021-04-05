//
//  FilmModel.swift
//  FilmSearch
//
//  Created by Antonio González Valdepeñas.
//

import Foundation

// MARK: - FilmModel
struct FilmModel: Codable {
    let id, title, year, length: String?
    let rating, ratingVotes: String?
    let poster: String?
    let plot: String?
    let trailer: Trailer?

    enum CodingKeys: String, CodingKey {
        case id, title, year, length, rating
        case ratingVotes = "rating_votes"
        case poster, plot, trailer
    }
}

// MARK: - Trailer
struct Trailer: Codable {
    let id: String?
    let link: String?
}
