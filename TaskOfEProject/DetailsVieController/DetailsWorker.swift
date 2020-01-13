//
//  DetailsWorker.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import UIKit

class DetailsWorker
{
    func getWeatherInfo(city: City,completionHandler: @escaping (WeatherInfo?,ErrorCode?) -> Void)
    {
        let url =  "\(Constants.Server.Services.getWeatherInfo)\(Constants.APIKEY)/\(city.lat),\(city.long)"
         RequestService.sendHttpRequest(httpMethod: .get,
                                       url:url,
                                       objectType: WeatherInfo.self, isRelativeUrl: false, params: nil, isAuth: false,
                                       customHeaders: [:],
                                       body: [:])
        { result, error  in
            if let authRespond = result
            {
                print(authRespond)
                completionHandler(authRespond ,nil )
            }
            else
            {
                if let apiEror = error
                {
                    print(apiEror)
                    completionHandler(nil , apiEror)
                } else
                {
                    completionHandler(nil , ErrorCode.UNKOWN_ERROR)
                }
            }
            
        }
        
    }
}
