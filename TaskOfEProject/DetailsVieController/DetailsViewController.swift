//
//  DetailsViewController.swift
//  TaskOfEProject
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//
import UIKit
import LBTAComponents

import FCAlertView
protocol DetailsDisplayLogic: class
{
    func displayWeatherInfo(viewModel: WeatherInfo)
    func displayIndecator()
    func stopIndecator()
    func createAlert(title: String, subTitle: String)
    
}

class DetailsViewController: DatasourceController, DetailsDisplayLogic
{
    let backgroundImageView: UIImageView = {
           let iv = UIImageView()
           iv.image = #imageLiteral(resourceName: "daytimeClear")
           iv.clipsToBounds = true
           return iv
       }()
    let errorMessageLabel: WhiteLabel = {
        let label = WhiteLabel(font: UIFont.systemFont(ofSize: 18))
        label.text = "Sorry, something went wrong. Please try again later..."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    var interactor: DetailsBusinessLogic?
    var router: (NSObjectProtocol & DetailsRoutingLogic & DetailsDataPassing)?
     var viewIndecator = loader ()
    // MARK: Object lifecycle
 // MARK: Object lifecycle
    
    // MARK: Setup
    
     func setup()
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
        setupErrorMessageLabel()
              setupCollectionView()
        getWeatherInfo()
    }
    
    // MARK: Do something
    fileprivate func setupErrorMessageLabel() {
           view.addSubview(errorMessageLabel)
           errorMessageLabel.anchorCenterSuperview()
           errorMessageLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
           errorMessageLabel.equalHeightToWidth()
       }
    fileprivate func setupCollectionView() {
         collectionView?.collectionViewLayout = IOSWeatherCollectionViewLayout()
         collectionView?.backgroundView = backgroundImageView
         collectionView?.showsVerticalScrollIndicator = false
         collectionView?.alwaysBounceVertical = true
     }
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
        self.datasource = WeatherDatasource(weatherModel: viewModel)
    }
    //@IBOutlet weak var nameTextField: UITextField!
    
    func getWeatherInfo()
    {
        let request = Details.Something.Request()
        interactor?.getWeatherInfo()
    }
    
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
         
         let offsetY = scrollView.contentOffset.y
         let headerHeightMaxChange = WeatherHeaders.topHeader.defaultHeight - WeatherHeaders.topHeader.minimumHeight
         var subOffset: CGFloat = 0
         if offsetY > headerHeightMaxChange {
             subOffset = offsetY - headerHeightMaxChange
         } else {
             subOffset = 0
         }
         NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationNames.setOffset), object: subOffset)
     }
     
     override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: view.frame.width, height: 720)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
         var height: CGFloat = WeatherHeaders.topHeader.defaultHeight
         if section != WeatherHeaders.topHeader.section {
             height = WeatherHeaders.centerHeader.defaultHeight
         }
          return CGSize(width:view.frame.width, height: height)
     }
    
}
extension DetailsViewController: FCAlertViewDelegate
{
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
    }
}
