//
//  NetworkDataFetcher.swift
//  PhotosLibrary
//
//  Created by Илья Лобков on 19.08.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    
    var networkSercice = NetworkService()
    
    func fetchImage(serchTerm: String, completion: @escaping (SearchResults?) -> ()) {
        networkSercice.request(searchTerm: serchTerm) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: SearchResults.self, frome: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable> (type:T.Type, frome: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = frome else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Faled to decode JSON", jsonError)
            return nil
        }
    }
}
