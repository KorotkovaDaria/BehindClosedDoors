//
//  NetworkManager.swift
//  BehindClosedDoors
//
//  Created by Daria on 08.05.2024.
//

import UIKit
    // MARK: - Enum
enum UrlString {
    static let infoHotel  = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/"
    static let photoHotel = "https://github.com/iMofas/ios-android-test/raw/master/"
}
    // MARK: - Protocol
protocol NetworkManagerProtocol {
    typealias HandlerList = (Result<[ListHotels], HotelErrors>) -> Void
    typealias HandlerHotel = (Result<InfoAboutHotel, HotelErrors>) -> Void
    
    func getListHotels(completed: @escaping HandlerList)
    func getInfoHotel(hotel id: Int?, completed: @escaping HandlerHotel)
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    // MARK: - Properties
    var session = URLSession.shared
    static let shared = NetworkManager()
    let cache   = NSCache<NSString, UIImage>()
    // MARK: - Func
    func getListHotels(completed: @escaping HandlerList) {
        let url = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json"
        guard let url = URL(string: url) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                        completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let hotels = try decoder.decode([ListHotels].self, from: data)
                completed(.success(hotels))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getInfoHotel (hotel id: Int?, completed: @escaping HandlerHotel) {
        guard let idHotel = id else { return }
        let endpoint = "\(UrlString.infoHotel)\(idHotel).json"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let hotel = try decoder.decode(InfoAboutHotel.self, from: data)
                completed(.success(hotel))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func downloadImage(from image: String, completed: @escaping (UIImage?) -> Void) {
        let endpoint = "\(UrlString.photoHotel)\(image)"
        let cacheKey = NSString(string: endpoint)
        let hdURLString = endpoint.replacingOccurrences(of: "100", with: "500")
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        guard let url = URL(string: hdURLString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse,response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}
