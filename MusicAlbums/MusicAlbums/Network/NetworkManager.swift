//
//  NetworkManager.swift
//  MusicAlbums
//
//  Created by Consultant on 11/24/22.
//

import Foundation

class NetworkManager {
    
    let session: URLSession
    let decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
}

extension NetworkManager: NetworkManagerType {
    func fetchModel<T: Decodable>(request: URLRequest?, completion: @escaping (Result<T, Error>) -> ())  {
        
        guard let request = request else{
            completion(.failure(Error.self as! Error))
            return
        }
        self.session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(data as! Error))
                return
            }
            do {
                let decoded = try self.decoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                print("Error decoding \(error)")
            }
        }.resume()
    }
    
    func fetchRawData(request: URLRequest?, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let request = request else{
            completion(.failure(Error.self as! Error))
            return
        }
        self.session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(data as! Error))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
    
}
