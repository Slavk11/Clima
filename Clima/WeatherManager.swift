//
//  WeatherManager.swift
//  Clima
//
//  Created by Сазонов Станислав on 31.10.2023.
//

import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(Constants.id)&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        // 1. Create a URL
        guard let url = URL(string: urlString) else { return }
        
        // 2. Create a URLSession
        let session = URLSession(configuration: .default)
        
        // 3. Give the session a task
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error {
                delegate?.didFailWithError(error: error)
                return
            }
            
            guard let safeData = data else { return }
            guard let weather = parseJSON(safeData) else { return }
            delegate?.didUpdateWeather(weather: weather)
        }
        
        // 4. Start the task
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            print("weatherData: \(weatherData)")
            if let jsonResponse = String(data: weatherData, encoding: String.Encoding.utf8) {
                print("Response: \(jsonResponse)")
            }
            
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let weather = WeatherModel(weatherData: decodeData)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
