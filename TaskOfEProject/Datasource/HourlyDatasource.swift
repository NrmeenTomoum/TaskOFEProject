//
//  HourlyDatasourceModel.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//
import LBTAComponents

class HourlyWeatherDatasource: Datasource {
    
    let hourlyWeather: [WeatherHourly]
    required init(weatherHourly: [WeatherHourly]) {
        self.hourlyWeather = weatherHourly
    }
        
    override func cellClasses() -> [DatasourceCell.Type] {
        return [VerticalWeatherCell.self]
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return hourlyWeather.count
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return hourlyWeather[indexPath.item]
    }
}
