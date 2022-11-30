//
//  NetworkParams.swift
//  MusicAlbums
//
//  Created by Consultant on 11/27/22.
//

import Foundation

enum NetworkParams {
    
    private struct NetworkConstants {
        static let mostPlayedUS = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/100/albums.json"
        static let albumURLBasePath = "https://is5-ssl.mzstatic.com/image/thumb/Music112/v4/"
    }
        
    
    private enum NetworkRequestType: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    case albumsMostPlayed
    case albumImage(_ path: String?)
    
    var request: URLRequest? {
        switch self {
        case .albumsMostPlayed:
            var urlComponents = URLComponents(string: NetworkConstants.mostPlayedUS)
            
//            var queryItems: [URLQueryItem] = []
//            queryItems.append(URLQueryItem(name: "page", value: "\(page)") )
            
            
//            urlComponents?.queryItems = queryItems
            guard let url = urlComponents?.url else {return nil}
            
            var request = URLRequest(url: url)
            request.httpMethod = NetworkRequestType.get.rawValue
            return request
            
        case .albumImage(let path):
            guard let path = path, let url = URL(string: path) else {return nil}
            var request = URLRequest(url: url)
            request.httpMethod = NetworkRequestType.get.rawValue
            
            return request
        }
        
    }
    
}
