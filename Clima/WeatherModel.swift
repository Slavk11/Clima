//
//  WeatherModel.swift
//  Clima
//
//  Created by Сазонов Станислав on 31.10.2023.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%1f", temperature)
    }
    
    var getConditionName: String {
        switch conditionId {
        case 200...232: return "cloud.bolt"
        case 300...321: return "cloud.drizzle"
        case 500...531: return "cloud.rain"
        case 600...622: return "cloud.snow"
        case 700...781: return "cloud.fog"
        case 800: return "sun.max"
        case 801...804: return "cloud.bolt"
        default: return "cloud"
        }
    }
    
    init(condition: Int, cityName: String, temperature: Double) {
        self.conditionId = condition
        self.cityName = cityName
        self.temperature = temperature
    }
    
    init(weatherData: WeatherData) {
        self.conditionId = weatherData.weather[0].id
        self.cityName = weatherData.name
        self.temperature = weatherData.main.temp
    }
}
