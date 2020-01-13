//
//  WeatherCellDetailDatasource.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import LBTAComponents

class WeatherCellDetailDatasource: Datasource {
    
    let weatherModel: WeatherInfo
    required init(weatherModel: WeatherInfo) {
        self.weatherModel = weatherModel
    }
    
    // This section only has 1 header, 1 cell and 1 footer.
    override func cellClasses() -> [DatasourceCell.Type] {
        return [TodayWeatherCell.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [DailyWeatherCell.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [ExtendedInfoCell.self]
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return 1
    }
    
    override func headerItem(_ section: Int) -> Any? {
        return weatherModel.daily.data
    }
    
    override func footerItem(_ section: Int) -> Any? {
        return weatherModel.daily.summary
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return weatherModel.daily.summary
    }
}
