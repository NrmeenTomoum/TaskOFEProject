//
//  WeatherDatasource.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import LBTAComponents
import UIKit
import SwiftyJSON


class WeatherDatasource: Datasource {
    
    let weatherModel: WeatherInfo
    
    required init(weatherModel: WeatherInfo)  {
        self.weatherModel = weatherModel
    }
        
    let headerCells: [DatasourceCell.Type] = [WeatherTopHeaderCell.self, WeatherSecondHeader.self]
    
    let cells: [DatasourceCell.Type] = [WeatherCell.self]
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return headerCells
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return cells
    }
    
    override func numberOfSections() -> Int {
        return headerCells.count
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return section == WeatherHeaders.topHeader.section ? 0 : cells.count // top section has no cells
    }
    
    override func headerItem(_ section: Int) -> Any? {
        
        return [weatherModel.timezone, weatherModel.hourly.data][section]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return weatherModel
    }
}



