//
//  DetailsPresenter.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import UIKit

protocol DetailsPresentationLogic
{
       func stopLoader()
   func presentLoader()
   func presentAlertMessage(message : String)
   func presentWeatherInfo(response: WeatherInfo)
    
}

class DetailsPresenter: DetailsPresentationLogic
{
  weak var viewController: DetailsDisplayLogic?
  
  // MARK: Do something
  
  func presentWeatherInfo(response: WeatherInfo)
   {
     viewController?.displayWeatherInfo(viewModel: response)
   }
     func stopLoader() {
         viewController?.stopIndecator()
     }
     
     func presentLoader() {
     viewController?.displayIndecator()
     }
     func presentAlertMessage(message : String)
     {
         viewController?.createAlert(title: "", subTitle: message)
     }
    
}
