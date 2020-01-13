//
//  DetailsViewController.swift
//  TaskOfEProject
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//
import UIKit

import FCAlertView
protocol DetailsDisplayLogic: class
{
    func displayWeatherInfo(viewModel: WeatherInfo)
    func displayIndecator()
    func stopIndecator()
    func createAlert(title: String, subTitle: String)
    
}

class DetailsViewController: UIViewController, DetailsDisplayLogic
{
    var interactor: DetailsBusinessLogic?
    var router: (NSObjectProtocol & DetailsRoutingLogic & DetailsDataPassing)?
     var viewIndecator = loader ()
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
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter()
        let router = DetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getWeatherInfo()
    }
    
    // MARK: Do something
    // to show message in alert view in View
    func createAlert(title: String, subTitle: String) {
        CAlert.createAlert(title: title, subTitle: subTitle,vc: self)
    }
    
    // to show indecator
    func displayIndecator()
    {
        viewIndecator.startIndecator(self.view)
    }
    // to stop indecator
    func stopIndecator()
    {
        viewIndecator.stopIndecator(self.view)
    }
    func displayWeatherInfo(viewModel: WeatherInfo) {
        print(viewModel.hourly.summary)
        //        displayedUsers = viewModel
        //        var setOfUsersFromCD: [NSManagedObject] = []
        //        DBManger.fetchCD("User", dataRetrived: &setOfUsersFromCD)
        //        print(setOfUsersFromCD)
        //        tableView.reloadData()
    }
    //@IBOutlet weak var nameTextField: UITextField!
    
    func getWeatherInfo()
    {
        let request = Details.Something.Request()
        interactor?.getWeatherInfo()
    }
    
  
}
extension DetailsViewController: FCAlertViewDelegate
{
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
    }
}
