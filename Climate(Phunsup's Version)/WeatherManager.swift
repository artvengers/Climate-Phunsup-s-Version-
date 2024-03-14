//
//  WeatherManager.swift
//  Climate(Phunsup's Version)
//
//  Created by Phunsup S. on 14/3/2567 BE.
//


import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(weatherManager: WeatherManager,weather: WeatherModel)
    
    func didFailWithError(error: Error)
}

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=6f6ce093ce75806e06c41c165279eefa&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        //let me = weatherURL+"&q="+cityName
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees,longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    
    //ใช้api
    func performRequest(urlString: String){
       
        // 1.create a url
        if let url = URL(string: urlString) {
            
            // 2.create a urlsession
            let session = URLSession(configuration: .default)
            
            // 3.give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data:  response:  error: ))
           
            // 4.start the task
            task.resume() //จำเป็นต้องสร้างเพื่อ start
            
        }
            }
    func handle(data: Data?, response: URLResponse?, error: Error?){
        if( error != nil){
            delegate?.didFailWithError(error: error!)
            return
        }
        
        if let safedata = data{
            if let weather = parseJSON(weatherData: safedata){
                DispatchQueue.main.async {
                    self.delegate?.didUpdateWeather(weatherManager: self,weather: weather)
                }
            }
        }
    }
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let idData = decodeData.weather[0].id
            let nameData = decodeData.name
            let tempData = decodeData.main.temp
            let weatherModel = WeatherModel(conditionID: idData, cityName: nameData, temperature: tempData)
            return weatherModel
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
