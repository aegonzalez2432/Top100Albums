//
//  MusicAlbumViewModel.swift
//  MusicAlbums
//
//  Created by Consultant on 11/27/22.
//

import Foundation

protocol MusicAlbumViewModelType {
    func bind(completion: @escaping() -> ())
    func fetchPage()
    var count: Int {get}
    func setButtonStates() -> Void
//    var buttonState: Bool {set}
    func getValAtIndex(index: Int) -> Bool
    var getFavList: [Results] {get}
    func buttonPressedAtIndex(for index: Int) -> Bool
    func getAlbumIndex(for album: Results) -> Int
    func albumTitle(for index: Int) -> String?
    func artist(for index: Int) -> String?
    func faveAlbum(for index: Int) -> Void
    func releaseDate(for index: Int) -> String?
    func albumGenres(for index: Int) -> [Genre]
    func imageData(for index: Int, completion: @escaping (Data?) -> ())
//    func favedAlbums(for index: Int) -> Results

    
}


class MusicAlbumViewModel {
    typealias UpdateHandler = (() -> ())
    
    private var musicPage: MusicPage?
    private var favList: [Results] = []
    private var buttonPressedBool: [Bool] = []
    private var favIndex: [Int] = []
    private var albums: [Results] = []
    private let networkManager: NetworkManagerType
    var updateHandler: UpdateHandler?
    var buttonToggle: Bool = false

    
    init(networkManager: NetworkManagerType = NetworkManager()) {
        self.networkManager = networkManager
    }
    
}
extension MusicAlbumViewModel: MusicAlbumViewModelType {
    func getValAtIndex(index: Int) -> Bool {
        return buttonPressedBool[index]
    }

    func buttonPressedAtIndex(for index: Int) -> Bool {
        if self.buttonPressedBool[index] == false {
            self.buttonPressedBool[index] = true
        } else {
            self.buttonPressedBool[index] = false
        }
        return buttonPressedBool[index]
    }
    
    func getAlbumIndex(for album: Results) -> Int {
        do{
            return albums.firstIndex(where: {$0.name == album.name}) ?? 200
        }
    }
    
    var getFavList: [Results] {
        return favList
    }
    
    func setButtonStates() {
        for _ in 0..<100 {
            self.buttonPressedBool.append(false)
        }
    }
    

    
    
    func faveAlbum(for index: Int) {
        self.favList.append(self.albums[index])
        self.favIndex.append(index)
    }
    
    func bind(completion: @escaping () -> ()) {
        self.updateHandler = completion
    }
    
    func fetchPage() {
        let req = NetworkParams.albumsMostPlayed.request
        
        
        self.networkManager.fetchModel(request: req) { (result: Result<MusicPage, Error>) in
            switch result {
                
            case .success(let resultie):
                let albumRes = resultie.feed.results
                self.albums.append(contentsOf: albumRes )
                self.updateHandler?()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var count: Int {
        return self.albums.count
    }
    
    func releaseDate(for index: Int) -> String? {
        guard index < self.count else {return nil}
        return self.albums[index].releaseDate
    }
    
    func albumGenres(for index: Int) -> [Genre] {
        guard index < self.count else {return []}
        return self.albums[index].genres
    }
    
    func albumTitle(for index: Int) -> String? {
        guard index < self.count else {return nil}
        return self.albums[index].name
    }
    
    func artist(for index: Int) -> String? {
        guard index < self.count else {return nil}
        return self.albums[index].artistName
    }
    
    func imageData(for index: Int, completion: @escaping (Data?) -> ()) {
        guard index < self.count else {return}
        
        let request = NetworkParams.albumImage("\(self.albums[index].artworkUrl100)").request
        
        self.networkManager.fetchRawData(request: request) { res in
            switch res {
            case .success(let data):
                completion(data)
                
            case .failure(let error):
                print("failed getting image: \(error)")
            }
        }
    }
}
