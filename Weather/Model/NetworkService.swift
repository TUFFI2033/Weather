//
//  NetworkService.swift
//  Weather
//
//  Created by Ivan Byndiu on 26/08/2023.
//

import Foundation
import UIKit

class NetworkService {
    static let shared = NetworkService()
    private init() { }
    
    func fetchData(cityName: String, completion: @escaping (Result<WeatherResults, Error>) -> ()) {
        
        let tunnel = "https://"
        let server = "api.weatherapi.com"
        let keys = "/v1/current.json?key=7a2cc6c0d78c43139c9185731232008&q="
        let endPoint = "&aqi=no"
        let urlString = tunnel + server + keys + cityName + endPoint

        let url = URL(string: urlString)
        
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let weatherData = try decoder.decode(WeatherResults.self, from: data)
                completion(.success(weatherData))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
        
    }

//    func createURL() -> URL? {
//        let tunnel = "https://"
//        let server = "api.weatherapi.com"
//        let keys = "/v1/current.json?key=7a2cc6c0d78c43139c9185731232008&q="
//        let cityName = "Chernivtsi"
//        let endPoint = "&aqi=no"
//        let urlString = tunnel + server + keys + cityName + endPoint
//
//        let url = URL(string: urlString)
//
//        return url
//    }
}






