//
//  SelectedAlbumVC.swift
//  MusicAlbums
//
//  Created by Consultant on 11/29/22.
//

import Foundation
import UIKit

class SelectedAlbumVC: UIViewController {

    lazy var albumImage: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .gray
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    lazy var artistName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .blue
        label.text = "Artist Name"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var albumName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .systemPink
        label.text = "Album Name"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var genres: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .purple
        label.text = "Genres"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var releaseDate: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .systemGreen
        label.text = "Release Date"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var loveButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        button.tintColor = .systemPink
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.scalesLargeContentImage = true
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
        
    }()
    var buttonIsPressed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(albumImage)
        self.view.addSubview(albumName)
        self.view.addSubview(artistName)
        self.view.addSubview(genres)
        self.view.addSubview(releaseDate)
        self.view.addSubview(loveButton)
        self.view.backgroundColor = .white
        
        
        self.albumImage.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -50).isActive = true
        self.albumImage.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.albumImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.albumImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.albumName.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.albumName.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        
        self.albumName.bottomAnchor.constraint(equalTo: self.albumImage.topAnchor, constant: -8).isActive = true
        
        
        self.releaseDate.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.releaseDate.topAnchor.constraint(equalTo: self.artistName.bottomAnchor, constant: 8).isActive = true
        self.releaseDate.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 8).isActive = true
        
        
        self.artistName.topAnchor.constraint(equalTo: self.albumImage.bottomAnchor, constant: 8).isActive = true
        
        self.artistName.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.artistName.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 8).isActive = true
        
        
        self.genres.topAnchor.constraint(equalTo: self.releaseDate.bottomAnchor, constant: 8).isActive = true
        
        self.genres.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.genres.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 8).isActive = true
        
        
        self.loveButton.topAnchor.constraint(equalTo: self.genres.bottomAnchor, constant: 8).isActive = true
        self.loveButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
        self.loveButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
    }
    @objc
    func buttonPressed() {
        //Deselected button
        if buttonIsPressed {
            DispatchQueue.main.async {
                self.loveButton.setImage(UIImage(systemName: "heart"), for: .normal)
                self.buttonIsPressed = false
            }

        //Selected button
        } else {
            DispatchQueue.main.async {
                self.loveButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.buttonIsPressed = true
            }

        }
    }
}
