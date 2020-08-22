//
//  MoreViewController.swift
//  PhotosLibrary
//
//  Created by Илья Лобков on 21.08.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit
class MoreViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dataDowload: UILabel!
    
    var data: String?
    var images: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = images
        dataDowload.text = data
    }
}
