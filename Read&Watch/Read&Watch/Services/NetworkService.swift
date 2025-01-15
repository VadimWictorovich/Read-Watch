//
//  NetworkService.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 11.01.25.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage


class NetworkService {
        
    static func getRequest<T: Codable>(url: String, header: HTTPHeaders, callback: @escaping (T?, Error?) -> ()) {
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .response { response in
                var searchItem: T?, err: Error?
                switch response.result {
                case .success(let data):
                    guard let data else { callback(nil, nil); return }
                    print(" ** ** ** у метода getRequest получена data \(JSON(data))")
                    do {
                        searchItem = try JSONDecoder().decode(T.self, from: data)
                    } catch (let decodError) { print(" *-*-* у \(#function) получен decodError--\(decodError)**") }
                case .failure(let error):
                    err = error
                }
                callback(searchItem, err)
        }
    }
    
    static func searchMoviesByName(movieName: String, callback: @escaping (_ result: DocsResponse?, _ error: Error?) -> ()) {
        let url = "https://api.kinopoisk.dev/v1.4/movie/search?page=1&limit=15&query=\(movieName)"
        let header: HTTPHeaders = ["X-API-KEY": NetworkProperties.apiKey]
        getRequest(url: url, header: header, callback: callback)
    }
    
    
     static func getMovieImage (imageURL: URL, callback: @escaping (_ result: UIImage?, _ error: Error?) -> ()) {
         AF.request(imageURL).responseImage { response in
             switch response.result {
             case .success(let image):
                 callback(image, nil)
             case .failure(let error):
                 callback(nil, error)
             }
         }
     }
    
}
