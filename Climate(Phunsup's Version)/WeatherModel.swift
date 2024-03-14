//
//  WeatherModel.swift
//  Climate(Phunsup's Version)
//
//  Created by Phunsup S. on 14/3/2567 BE.
//

import Foundation

struct WeatherModel{
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var teperaturString: String{
        return String(format: "%.1f", temperature)
    }
    var conditionName: String {
        switch conditionID{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 500...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}

