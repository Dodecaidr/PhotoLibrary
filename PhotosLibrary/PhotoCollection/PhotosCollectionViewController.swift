//
//  PhotosCollectionViewController.swift
//  PhotosLibrary
//
//  Created by Илья Лобков on 18.08.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "PhotosCell"

class PhotosCollectionViewController: UICollectionViewController {
    
    var networkDataFetcher = NetworkDataFetcher()
    private var timer: Timer?
    
    private var photos = [UnsplashPhoto]()
    
    private let realm = try! Realm()
    var dataPhotoRes: Results<PhotosLibraryRealm>? = nil
    
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    private var widhCell: CGFloat = 0
    private var heightCell: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSearchBar()
        dataPhotoRes = realm.objects(PhotosLibraryRealm.self)
    }
    
    
    // MARK: - Setup UI Elements
    
    private func setupCollectionView() {
        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.reuseId)
        
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.allowsMultipleSelection = true
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self 
        
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataPhotoRes = dataPhotoRes else { return 1 }
        print("КОЛЛИЧЕСТВО ДАННЫХ =  \(dataPhotoRes.count)")
        return dataPhotoRes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseId, for: indexPath) as! PhotosCell
        
        guard let dataPhotoRes = dataPhotoRes else {return cell }
        let data = dataPhotoRes[indexPath.row]
        
        cell.photoImageView.image = UIImage(data: data.imageV)
        cell.infoLabel.text = data.id
        return cell
    }
    
}

// MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchImage(serchTerm: searchText) { [weak self ](searchResults) in
                DispatchQueue.main.async {
                    guard let fetchPhotos = searchResults else { return }
                    self?.deliteRealmData()
                    self?.recordRealmData(data: fetchPhotos.results)
                }
            }
        })
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "mores", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "mores" else { return }
        guard let vc = segue.destination as? MoreViewController else { return }
        guard let sender = sender else { return }
        
        let index: Int = sender as! Int
        guard let dataPhotoRes = dataPhotoRes else { return }
        guard let image = UIImage(data: (dataPhotoRes[index].imageV))  else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: dataPhotoRes[index].data)
        
        vc.images = image
        vc.data = dateString
    }
}

//MARK: - Realm

extension PhotosCollectionViewController {
    func deliteRealmData() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func recordRealmData(data: [UnsplashPhoto]) {
        
        for i in 0..<data.count {
            
            let realm = try! Realm()
            let photoUrl = data[i].urls["thumb"]
            guard let inmageUrl = photoUrl, let url = URL(string: inmageUrl) else { return }
            let imageV = UIImage(data: try! Data(contentsOf: url))
            
            
            let dataPhotoR = PhotosLibraryRealm()
            
            try! realm.write {
                dataPhotoR.id = data[i].id
                dataPhotoR.data = Date()
                dataPhotoR.imageV = imageV!.pngData()!
                realm.add(dataPhotoR)
            }
        }
        self.collectionView.reloadData()
    }
}
