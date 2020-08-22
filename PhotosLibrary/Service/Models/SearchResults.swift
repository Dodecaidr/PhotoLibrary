//
//  SearchResults.swift
//  PhotosLibrary
//
//  Created by Илья Лобков on 19.08.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let id: String
    let urls: [URLKing.RawValue: String]
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
