//
//  HomeMapInteractor.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import UIKit

protocol HomeMapBusinessLogic
{
     func setCityValue(city: City)
}

protocol HomeMapDataStore
{
    var city: City?{ get set }
}

class HomeMapInteractor: HomeMapBusinessLogic, HomeMapDataStore
{
    var city: City?
    
    // MARK: Do something
    
    func setCityValue(city: City)
    {
        self.city = city
    }
}
