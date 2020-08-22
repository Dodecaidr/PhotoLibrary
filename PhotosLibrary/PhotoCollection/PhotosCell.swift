//
//  PhotosCell.swift
//  PhotosLibrary
//
//  Created by Илья Лобков on 20.08.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit
import SDWebImage

class PhotosCell: UICollectionViewCell {
    static let reuseId =  "PhotosCells"
    
    var infoLabel: UILabel = {
        let text = "info"
        let lable = UILabel()
        lable.text = text
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        return lable
    }()
    
    var  photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupInfoLable()
    }
    
    private func setupImageView() {
        addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.widthAnchor.constraint(equalToConstant: width()).isActive = true
        self.heightAnchor.constraint(equalToConstant: hieght()).isActive = true
    }
    
    private func setupInfoLable() {
        addSubview(infoLabel)
        infoLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: 8).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func hieght () -> CGFloat {
        let hieght = UIScreen.main.bounds.height / 6
        return hieght
    }
    
    private func width () -> CGFloat {
        let width = UIScreen.main.bounds.width / 2 - 30
        return width
    }
}
