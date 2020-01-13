//
//  HomeMapViewController.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import UIKit
import GoogleMaps
protocol HomeMapDisplayLogic: class
{
}

class HomeMapViewController: UIViewController, HomeMapDisplayLogic
{
    var interactor: HomeMapBusinessLogic?
    var router: (NSObjectProtocol & HomeMapRoutingLogic & HomeMapDataPassing)?
    var cities : [City] = []
    var tappedmarker = GMSMarker()
    var customMarker = CustomMarker()
      var mapView = GMSMapView()
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = HomeMapInteractor()
        let router = HomeMapRouter()
        viewController.interactor = interactor
        viewController.router = router
      router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
   
    override func loadView() {
        cities = [City(name: "Dubai",lat : 25.276987 , long: 55.296249),City(name: "Ajman",lat : 25.41111 , long: 55.43504),City(name: "Sharjah",lat : 25.3463 , long: 55.4209)]
        // Create a GMSCameraPosition that tells the map to display the
          let camera = GMSCameraPosition.camera(withLatitude: 25.276987, longitude: 55.296249, zoom: 10.0)
  mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        mapView.delegate = self
        var i = 0
        for city in cities {
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: city.lat, longitude: city.long)
            marker.title = "UAE"
            marker.userData = i
            marker.snippet = city.name
            marker.map = mapView
            i += 1
        }
        // Creates a marker in the center of the map.
    }
    override func viewDidLoad()
       {
           super.viewDidLoad()
         
       }
       
}
extension HomeMapViewController: GMSMapViewDelegate
{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("masrker taped",marker.snippet)
        self.tappedmarker = marker
          if self.customMarker.isexist == true
        {
              self.customMarker.removeFromSuperview()
        }
        
        self.customMarker = CustomMarker.instancefromNib() as! CustomMarker
        customMarker.layer.cornerRadius = 10.0
        customMarker.clipsToBounds = true
        self.customMarker.isexist = true
        self.customMarker.delegate = self
        self.customMarker.center = mapView.projection.point(for: marker.position)
        self.customMarker.center.y = self.customMarker.center.y - 100
        self.view.addSubview(self.customMarker)
        
        return true
    }
}
extension HomeMapViewController : CustomMarkerDelegate
{
    func showDetailsOfSelectedCity() {
      self.customMarker.removeFromSuperview()
        var index = tappedmarker.userData as! Int
        var selectedCity = cities[index]
        self.interactor?.setCityValue(city: selectedCity)
      router?.routeToDetailsVC()
    }
}

