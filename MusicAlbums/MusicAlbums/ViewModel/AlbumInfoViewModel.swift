//
//  AlbumInfoViewModel.swift
//  MusicAlbums
//
//  Created by Consultant on 11/30/22.
//

import Foundation

class AlbumInfoViewModel {
    private var manager: CoreDataManager
    private var albumInfo: AlbumInfo? {
        didSet {
            self.updateHandler?()
        }
    }
    private var updateHandler: (() -> ())?
    
    init(manager: CoreDataManager = CoreDataManager()) {
        self.manager = manager
    }
    
    func bind(updateHandler: @escaping () -> ()) {
        self.updateHandler = updateHandler
    }
}

extension AlbumInfoViewModel {
    
    func makeAlbum(albName: String, albImage: String, artName: String, genre: String, relDate: String) {
        self.albumInfo = self.manager.buildAlbum(albName: albName, albImage: albImage, artName: artName, genre: genre, relDate: relDate)
        print("album info:\(self.albumInfo)")
        self.manager.saveContext()
    }
    func loadAlbum() {
        self.albumInfo = self.manager.fetchAlbumInfo()
    }
    
    func deleteAlbum() {
        if let album = self.albumInfo {
            self.manager.deleteAlbumInfo(album: album)
        }
        self.albumInfo = nil
    }
    
}
