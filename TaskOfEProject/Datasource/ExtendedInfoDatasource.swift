//
//  ExtendedInfoDatasource.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//
import LBTAComponents
import UIKit
import Foundation

protocol WeatherFormatable {
    func floatToPercentageString(float: Float) -> String
    func addUnit(_ unitName: String, toNumber: Float) -> String
}

extension WeatherFormatable {
    func floatToPercentageString(float: Float) -> String {
        return "\(Int(float * 100))" + " %"
    }
    
    func addUnit<T>(_ unitName: String, toNumber: T) -> String {
        return "\(toNumber) \(unitName)"
    }
    
    func addDegreeSign<T>(toNumber: T)-> String {
        return "\(toNumber)°"
    }
    
}


enum ExtendedInfo: String {
    case sunrise, sunset, chanceOfRain, humidity, wind, feelLike, precipitation, pressure, visibility, uvIndex
    
    var stringValue: String {
        var textString = ""
        switch self {
        case .uvIndex:
            textString = "UV INDEX"
        case .chanceOfRain:
            textString = "CHANCE OF RAIN"
        case .feelLike:
            textString = "FEEL LIKE"
        default:
            textString = self.rawValue.uppercased()
        }
        return "\(textString):  "
    }
}
struct WeatherExtendedInfoViewModel: WeatherFormatable {
    
    private var info: WeatherDaily
    init(weatherExtendedInfo: WeatherDaily) {
        self.info = weatherExtendedInfo
    }
    func setupString(key: ExtendedInfo) -> String {
        switch key {
        case .sunrise:
            
            return "\(info.sunriseTime)"
        case .sunset:
            return  "\(info.sunsetTime)"
     case .humidity:
            return floatToPercentageString(float: Float(info.humidity))
        case .wind:
            return  " " + addUnit(GlobalConstant.Units.windSpeed, toNumber: info.windSpeed)
        case .feelLike:
            return addDegreeSign(toNumber: "\(info.apparentTemperatureHighTime)")
        case .precipitation:
            return addUnit(GlobalConstant.Units.precipitation, toNumber: info.precipIntensity)
        case .pressure:
            return addUnit(GlobalConstant.Units.pressure, toNumber: info.pressure)
        case .visibility:
            return addUnit(GlobalConstant.Units.visibility, toNumber: info.visibility)
        case .uvIndex:
            return "\(info.uvIndex)"
       
        case .chanceOfRain:
            return "don'tkonw"
        }
    }
}

class ExtendedInfoDatasource: Datasource {
    
    let extendedInfo: [ExtendedInfo] = [.sunrise, .sunset, .chanceOfRain, .humidity, .wind, .feelLike, .precipitation, .pressure, .visibility, .uvIndex]
    let weatherExtendedInfoViewModel: WeatherExtendedInfoViewModel
    required init(weatherExtendedInfo: WeatherDaily) {
        self.weatherExtendedInfoViewModel = WeatherExtendedInfoViewModel(weatherExtendedInfo: weatherExtendedInfo)
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [ExtendedDetailCell.self]
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return extendedInfo.count
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        let infoString = weatherExtendedInfoViewModel.setupString(key: extendedInfo[indexPath.item])
        return [extendedInfo[indexPath.item]: infoString]
    }
}
