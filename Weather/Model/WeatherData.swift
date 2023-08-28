//
//  WeatherData.swift
//  Weather
//
//  Created by Ivan Byndiu on 28/08/2023.
//

import Foundation

struct WeatherResults: Decodable {
    let location: Location
    let current: Current
    
    struct Location: Decodable {
        let name: String
        let country: String
    }
    
    struct Current: Decodable {
        let tempC: Double
        let condition: Condition
        
        struct Condition: Decodable {
            let text: String
        }
    }
}
