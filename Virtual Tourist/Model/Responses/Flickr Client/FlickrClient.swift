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
    
    class func taskForGetRequest<ResponseType : Decodable>(url : URL,responseType : ResponseType.Type, completion : @escaping(ResponseType?, Error?)->Void)->URLSessionTask{
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else{
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            print(String(data: data, encoding: .utf8)!) //to print out the data-- DONT FORGETTT!!!
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch  {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
        return task
    }
    
    class func getPhotos(latitude : Double, longitude : Double, completion : @escaping(PhotoResponse?, Error?)->Void){
        taskForGetRequest(url: Endpoints.getPhotos(latitude, longitude).url, responseType: PhotoResponse.self) { response, error in
            if let response = response{
                completion(response.self, nil)
                print(response)
            }else{
                completion(nil, error)
            }
        }
        
    }
    
}
