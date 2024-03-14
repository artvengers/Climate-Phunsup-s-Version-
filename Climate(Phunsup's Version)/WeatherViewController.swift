//
//  ViewController.swift
//  Climate(Phunsup's Version)
//
//  Created by Phunsup S. on 14/3/2567 BE.
//

import UIKit


import UIKit
import CoreLocation
class WeatherViewController: UIViewController,UITextFieldDelegate,WeatherManagerDelegate {
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManage = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManage.delegate = self
        locationManage.requestWhenInUseAuthorization()
        locationManage.requestLocation()
        
        // ตัวช่วย
        searchTextField.delegate = self
        
        weatherManager.delegate = self
        
        
        
    }

    @IBOutlet weak var searchTextField: UITextField!
    
    // กดที่ปุ่ม ค้นหา
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    //กดที่ปุ่ม Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //กดค้นหาเสร็จให้คีบอดหยุดทำงาน
        searchTextField.endEditing(true)
    }
    
    // ถ้าไม่ใส่อะไรในช่องค้นหาจะไม่ให้หยุดการทำงานขของคีบอด
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.text != ""){
            return true
        }else {
            textField.placeholder = "Type City"
            return false
        }
    }
    
    // เมื่อ EndEditing แล้ว ให้ทำอะไร
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        
    }
    
    func didUpdateWeather(weatherManager: WeatherManager,weather: WeatherModel){
        temperatureLabel.text = weather.teperaturString
        cityLabel.text = weather.cityName
        conditionImageView.image = UIImage(systemName: weather.conditionName)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    
}

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}


