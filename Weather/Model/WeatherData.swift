//
//  WeatherData.swift
//  Weather
//
//  Created by Ivan Byndiu on 28/08/2023.
//

import Foundation

struct WeatherResults: Decodable {
    let location: Location
    var current: Current
    
    struct Location: Decodable {
        let name: String
        let country: String
    }
    
    struct Current: Decodable {
        let tempC: Double
        var condition: Condition
        let windKph: Double
        
        struct Condition: Decodable {
            let text: String
            var icon: String
            let code: Int
        }
    }
    
}

