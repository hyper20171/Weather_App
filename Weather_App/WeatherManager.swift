//
//  WeatherManager.swift
//  Weather_App
//
//  Created by Philip Tran on 12/1/20.
//  Copyright © 2020 Vincent Tran. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    var delegate:WeatherManagerDelegate?
    var apiKey = "" //Must register for apikey and put it in here for program to work. 
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid="
    
    func getWeather(city:String){
        let urlString = "\(weatherURL)\(apiKey)&q=\(city)"
        preformRequest(with:urlString)
    }
    
    func preformRequest(with urlString:String){
        if let url = URL(string:urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error:error!)
                    return
                }
                
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather:weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData:Data)->WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather  //Returns an object of all the useful information that you want to display on UI.
        }
        catch{
            delegate?.didFailWithError(error:error)
            return nil
        }
    }
}
