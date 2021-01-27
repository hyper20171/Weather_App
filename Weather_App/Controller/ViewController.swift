//
//  ViewController.swift
//  Weather_App
//
//  Created by Philip Tran on 11/30/20.
//  Copyright © 2020 Vincent Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var search: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
}

//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {  //Delegate for text field.
    
    @IBAction func searchPressed(_ sender: UIButton) {  //Method for button when pressed.
        searchTextField.endEditing(true) //Tells textfield that it is done editing.
        //Forcefully makes text field done editing.
    }
    //Asumming that these other methods are interface methods to be implemented.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //When text field is forcefully done editing,
        //double checks to see if text field should be done editing.
        //Returns true to continue ending text field.
        //Double process.
        if textField.text != "" {
            return true
        } else {    //If it's empty string.
            textField.placeholder = "Type something"
            return false
        }
        //Returns true if the textfield should be done editing. False otherwise.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Officially done editing, this will be executing.
        if let city = searchTextField.text {
            weatherManager.getWeather(city: city)
        }
        
        searchTextField.text = ""
        //What should happen when text is done editing.
    }
}

//MARK: - WeatherManagerDelegate

//Multiple files there just to make program more understandable.
//Technically you can just write one big program.
extension ViewController: WeatherManagerDelegate {
    //Gets called when data is successfully retrieved.
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        //Updates main storyboard.
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            /*
             self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            */
        }
    }
    //Gets called when error appears.
    func didFailWithError(error: Error) {
        print(error)
    }
}

