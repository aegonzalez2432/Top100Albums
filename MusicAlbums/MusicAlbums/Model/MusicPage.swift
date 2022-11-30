//
//  MusicPage.swift
//  MusicAlbums
//
//  Created by Consultant on 11/24/22.
//

import Foundation

struct MusicPage: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let results: [Results]
}


struct Results: Decodable {
    let artistName: String
    let id: String
    let name: String
    let releaseDate: String
    let artworkUrl100: URL
    let genres: [Genre]
}

struct Genre: Decodable, Equatable {
    let name: String
}
