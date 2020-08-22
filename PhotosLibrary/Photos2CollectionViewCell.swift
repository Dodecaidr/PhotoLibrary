//
//  Photos2CollectionViewCell.swift
//  PhotosLibrary
//
//  Created by Илья Лобков on 21.08.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit
import SDWebImage

class Photos2CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView! 
    @IBOutlet weak var label: UILabel!
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet{
            let photoUrl = unsplashPhoto.urls["thumb"]
            guard let inmageUrl = photoUrl, let url = URL(string: inmageUrl) else { return }
            //imageView.downloaded(from: url)
            imageView.sd_setImage(with: url, completed: nil)
            // imageView.image
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
