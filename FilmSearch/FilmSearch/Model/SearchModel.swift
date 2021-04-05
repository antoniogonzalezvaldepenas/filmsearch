//
//  SearchModel.swift
//  FilmSearch
//
//  Created by Antonio González Valdepeñas.
//

import Foundation

struct SearchModel: Codable {
    let titles: [Title]?
}

struct Title: Codable {
    let title: String?
    let image: String?
    let id: String?
}
