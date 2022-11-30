//
//  MusicAlbumViewCell.swift
//  MusicAlbums
//
//  Created by Consultant on 11/22/22.
//

import Foundation
import UIKit

class MusicAlbumViewCell: UICollectionViewCell {
    
    static let reuseID = "\(MusicAlbumViewCell.self)"
    
    lazy var albumTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .purple
        label.text = "Album Title"
//        label.textColor = .yellow
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var artist: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Artist"
        label.backgroundColor = .brown
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var albumImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "house")
        
        return image
    }()
    
    
    
    
    lazy var favButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        button.backgroundColor = .blue
        button.tintColor = .systemPink
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        return button
    }()
    var buttonIsPressed: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewDidLoad() {
        super.inputViewController?.viewDidLoad()
    }
    
    func createUI() {
        self.contentView.addSubview(self.albumTitleLabel)
        self.contentView.addSubview(self.favButton)
        self.contentView.addSubview(self.albumImage)
        self.contentView.addSubview(self.artist)
        self.contentView.backgroundColor = .systemGray3

        self.albumTitleLabel.topAnchor.constraint(equalTo: self.albumImage.bottomAnchor, constant: 2).isActive = true
        self.albumTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 2).isActive = true
        self.albumTitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -2).isActive = true
        self.albumTitleLabel.bottomAnchor.constraint(equalTo: self.artist.topAnchor, constant: -2).isActive = true
//        self.albumTitleLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.favButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -2).isActive = true
        self.favButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -2).isActive = true
        
        self.artist.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 2).isActive = true
        self.artist.trailingAnchor.constraint(equalTo: self.favButton.leadingAnchor, constant: -2).isActive = true
        self.artist.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -2).isActive = true
//        self.artist.topAnchor.constraint(equalTo: self.albumTitleLabel.bottomAnchor, constant: 8).isActive = true
        
        self.albumImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2).isActive = true
        self.albumImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
    
    @objc
    func buttonPressed() {
        print("button pressed")
        //Deselected button
        if buttonIsPressed {
            DispatchQueue.main.async {
                self.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
                self.buttonIsPressed = false
            }

        //Selected button
        } else {
            DispatchQueue.main.async {
                self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.buttonIsPressed = true
            }

        }
    }
    
    
}
