//
//  ViewController.swift
//  MusicAlbums
//
//  Created by Consultant on 11/21/22.
//

import UIKit

class MusicAlbumViewController: UIViewController {
    
    lazy var musicTable: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.size.width/2)-13, height: (view.frame.size.height/4))
        let table = UICollectionView(frame: .zero, collectionViewLayout: layout)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.sizeToFit()
        table.backgroundColor = .blue
        table.dataSource = self
        table.delegate = self
        table.register(MusicAlbumViewCell.self, forCellWithReuseIdentifier: "AlbumCell") 
        
        
        return table
    }()
    
    let musicAlbumViewModel: MusicAlbumViewModelType
    
    init(viewModel: MusicAlbumViewModelType) {
        self.musicAlbumViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()

        self.musicAlbumViewModel.bind {
            DispatchQueue.main.async {
                self.musicTable.reloadData()
            }
        }
        
        self.musicAlbumViewModel.fetchPage()
    }
    

    func createUI() {
        self.view.addSubview(self.musicTable)
        
        self.musicTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.musicTable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.musicTable.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.musicTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
    }
    
}

extension MusicAlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as? MusicAlbumViewCell else {
            print("could not make cell")
            return  UICollectionViewCell()}
        
        switch self.tabBarItem.tag {
        case 0:
            self.view.backgroundColor = .systemMint
            
            cell.albumTitleLabel.text = self.musicAlbumViewModel.albumTitle(for: indexPath.row)
            cell.artist.text = self.musicAlbumViewModel.artist(for: indexPath.row)
            self.musicAlbumViewModel.imageData(for: indexPath.row, completion: { data in
                DispatchQueue.main.async {
                    if let data = data {
                        cell.albumImage.image = UIImage(data: data)
                    }
                }
            })
        case 1:

            self.view.backgroundColor = .systemPurple
            if cell.albumTitleLabel.text == "Album Title"{
                cell.isHidden = true
            }

        default:
            print("idk whats wrong")
        }
        return cell
    }

}

extension MusicAlbumViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumChosen = SelectedAlbumVC()
        
        albumChosen.artistName.text = self.musicAlbumViewModel.artist(for: indexPath.row)
        albumChosen.albumName.text = self.musicAlbumViewModel.albumTitle(for: indexPath.row)
        albumChosen.genres.text = self.musicAlbumViewModel.albumGenres(for: indexPath.row).compactMap({ elem in
            elem.name
        }).joined(separator: ", ")
        albumChosen.releaseDate.text = dateReadable(date: self.musicAlbumViewModel.releaseDate(for: indexPath.row) ?? "")
        
        self.musicAlbumViewModel.imageData(for: indexPath.row, completion: { data in
            DispatchQueue.main.async {
                if let data = data {
                    albumChosen.albumImage.image = UIImage(data: data)
                }
            }
        })
        
        self.navigationController?.pushViewController(albumChosen, animated: false)
    }
    func dateReadable(date: String) -> String {
        let dateArr = date.split(separator: "-")
        switch dateArr[1] {
        case "01":
            return "Released: January \(dateArr[2]), \(dateArr[0])"
        case "02":
            return "Released: February \(dateArr[2]), \(dateArr[0])"
        case "03":
            return "Released: March \(dateArr[2]), \(dateArr[0])"
        case "04":
            return "Released: April \(dateArr[2]), \(dateArr[0])"
        case "05":
            return "Released: May \(dateArr[2]), \(dateArr[0])"
        case "06":
            return "Released: June \(dateArr[2]), \(dateArr[0])"
        case "07":
            return "Released: July \(dateArr[2]), \(dateArr[0])"
        case "08":
            return "Released: August \(dateArr[2]), \(dateArr[0])"
        case "09":
            return "Released: September \(dateArr[2]), \(dateArr[0])"
        case "10":
            return "Released: October \(dateArr[2]), \(dateArr[0])"
        case "11":
            return "Released: November \(dateArr[2]), \(dateArr[0])"
        case "12":
            return "Released: December \(dateArr[2]), \(dateArr[0])"
        default:
            return "Released: Gahhhhh some date"
        }
    }
}