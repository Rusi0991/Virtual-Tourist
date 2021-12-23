//
//  FlickrClient.swift
//  Virtual Tourist
//
//  Created by Ruslan Ismayilov on 12/9/21.
//

import Foundation
struct PhotoResponse: Codable {
    
    let photos: Photos
    let status: String
    
    enum CodingKeys: String, CodingKey{
        case photos = "photos"
        case status = "stat"
    }

struct Photos : Codable{
    let page Int
    let pages : String
    let photos : Int
    let perPage : String
    let photo : [FlickrPhoto]
    
}

struct FlickrPhoto : Codable{
    let id : String
    let owner : String
    let secret : String
    let server : String
    let farm : Int
    let title : String
    let isPublic : Int
    let isUser : Int
    let isFamily : Int
}

