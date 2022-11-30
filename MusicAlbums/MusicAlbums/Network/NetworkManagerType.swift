//
//  NetworkManagerType.swift
//  MusicAlbums
//
//  Created by Consultant on 11/24/22.
//

import Foundation

protocol NetworkManagerType {
    func fetchModel<T: Decodable>(request: URLRequest?, completion: @escaping (Result<T, Error>) -> ())
    func fetchRawData(request: URLRequest?, completion: @escaping (Result<Data, Error>) -> ())
}
