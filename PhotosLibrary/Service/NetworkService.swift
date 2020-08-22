//
//  NetworkService.swift
//  PhotosLibrary
//
//  Created by Илья Лобков on 18.08.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import Foundation

class NetworkService {
     
    func request(searchTerm: String, complition: @escaping (Data?, Error?) -> Void ) {
        
        let parametrs = self.prepareParaments(searchTerm: searchTerm)
        let url = self.url(params: parametrs)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: complition)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String:String]()
        headers["Authorization"] = "Client-ID ylyP3K3tnBeRhcNHYXDygubIleMkSmJThL3o8ufBuDo"
        return headers
    }
    
    private func prepareParaments(searchTerm: String) -> [String:String] {
        var parametrs = [String: String]()
        parametrs["query"] = searchTerm
        parametrs["page"] = String(1)
        parametrs["per_page"] = String(100)
        return parametrs
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
