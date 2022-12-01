//
//  CoreDataManager.swift
//  MusicAlbums
//
//  Created by Consultant on 11/29/22.
//

import Foundation
import CoreData

class CoreDataManager {
    lazy var persistentContainer: NSPersistentContainer = {
       let cont = NSPersistentContainer(name: "MusicAlbums")
        cont.loadPersistentStores { description, error in
            if let _ = error {
                fatalError("Setup gone awry")
            }
        }
        return cont
    }()

    func saveContext() {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    func buildAlbum(albName: String, albImage: String, artName: String, genre: String, relDate: String) -> AlbumInfo? {
        let context = self.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "AlbumInfo", in: context) else {return nil}
        
        let album = AlbumInfo(entity: entity, insertInto: context)
        album.releaseDate = relDate
        album.albumName = albName
        album.albumImage = albImage
        album.artistName = artName
        album.albumGenre = genre
        
        return album
    }
    
    func fetchAlbumInfo() -> AlbumInfo? {
        let context = self.persistentContainer.viewContext
        let request: NSFetchRequest<AlbumInfo> = AlbumInfo.fetchRequest()
        
        do {
            let res = try context.fetch(request)
            if let first = res.last {
                return first
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func deleteAlbumInfo(album: AlbumInfo)  {
        let context = self.persistentContainer.viewContext
        context.delete(album)
        self.saveContext()
    }
}
