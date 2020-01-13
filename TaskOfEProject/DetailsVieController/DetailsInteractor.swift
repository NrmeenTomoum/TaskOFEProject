//
//  DetailsInteractor.swift
//  TaskOfEProject
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//
import UIKit

protocol DetailsBusinessLogic
{
    func getWeatherInfo()
}

protocol DetailsDataStore
{
    var city: City?{ get set }
}

class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore
{
    var presenter: DetailsPresentationLogic?
    var worker: DetailsWorker?
    var city: City?
    var weatherInfo : WeatherInfo?
    // MARK: Do something
    
    func getWeatherInfo()
    {
        worker = DetailsWorker()
        worker?.getWeatherInfo(city: city!, completionHandler: { (weatherInfo, errorCode) in
            self.presenter?.stopLoader()
            if let response = weatherInfo
            {
                self.weatherInfo = response
                print(weatherInfo?.hourly.summary,weatherInfo?.latitude)
                self.presenter?.presentWeatherInfo(response: response)
            }
            else if let error = errorCode
            {
                
                self.presenter?.presentAlertMessage(message: (error.rawValue))
            }
        })
        
    }
}
