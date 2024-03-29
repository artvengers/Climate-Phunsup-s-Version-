//
//  WeatherData.swift
//  Climate(Phunsup's Version)
//
//  Created by Phunsup S. on 14/3/2567 BE.
//

import Foundation

struct WeatherData: Decodable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable{
    let temp: Double
}

struct Weather: Decodable{
    let id: Int
    let description: String
}

