//
//  RealmModelData.swift
//  PhotosLibrary
//
//  Created by Илья Лобков on 22.08.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import Foundation
import RealmSwift

class PhotosLibraryRealm: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var data: Date = Date()
    @objc dynamic var imageV: Data = Data()
}
