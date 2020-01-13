//
//  HomeMapRouter.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import UIKit

@objc protocol HomeMapRoutingLogic
{
  func routeToDetailsVC()
}

protocol HomeMapDataPassing
{
  var dataStore: HomeMapDataStore? { get }
}

class HomeMapRouter: NSObject, HomeMapRoutingLogic, HomeMapDataPassing
{
  weak var viewController: HomeMapViewController?
  var dataStore: HomeMapDataStore?
  
  // MARK: Routing
  
  func routeToDetailsVC()
  {
    let destinationVC = DetailsViewController()
    destinationVC.setup()
    var destinationDS = destinationVC.router!.dataStore!
      passDataToDetailsVC(source: dataStore!, destination: &destinationDS)
    navigateToDetailsVC(source: viewController!, destination: destinationVC)
    
  }

  // MARK: Navigation
  
  func navigateToDetailsVC(source: HomeMapViewController, destination: DetailsViewController)
  {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  
  func passDataToDetailsVC(source: HomeMapDataStore, destination: inout DetailsDataStore)
  {
    destination.city = source.city
  }
}
