//
//  WeatherData.swift
//  Weather_App
//
//  Created by Philip Tran on 12/1/20.
//  Copyright © 2020 Vincent Tran. All rights reserved.
//

import Foundation

struct WeatherData: Codable {           //Main code. Everything under is just supporting this struct.
    let name: String
    let main: Main
    let weather: [Weather]          //Var names have to exactly match one on web page for this to work.
}

struct Main: Codable {  //Decodable & encodable
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
