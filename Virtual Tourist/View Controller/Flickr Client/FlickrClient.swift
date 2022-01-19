//
//  FlickrClient.swift
//  Virtual Tourist
//
//  Created by Ruslan Ismayilov on 1/19/22.
//

import Foundation

class FlickrClient{
    enum Endpoints{
        static let base =
        "https://api.flickr.com/services/rest/?method=flickr.photos.search"
        
        case getPhotos(Double, Double)
        struct Auth{
            static let apiKey = "2ddf34e0a0c40a46fce758516d13eb93"
        }
        var stringValue : String {
            switch self{
            case.getPhotos(let latitude, let longitude) :
                return Endpoints.base + "&api_key=\(Auth.apiKey)&lat=\(latitude)&lon=\(longitude)&per_page=20&page=\(Int.random(in: 1...10))&format=json&nojsoncallback=1"
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
}
