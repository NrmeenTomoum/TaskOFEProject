//
//  TodayWeatherCell.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import LBTAComponents

class TodayWeatherCell: DatasourceCell {
    
    let todayLabel: WhiteLabel = {
        let label = WhiteLabel(font: UIFont.systemFont(ofSize: 12))
        label.numberOfLines = 0
        return label
    }()
    
    override var datasourceItem: Any? {
        didSet{
            guard let weatherLongDescription = datasourceItem as? WeatherDaily else { return }
            todayLabel.text = weatherLongDescription.summary
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(todayLabel)
        todayLabel.anchorWithConstantsToTop(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 4, leftConstant: GlobalConstant.margin, bottomConstant: 4, rightConstant: GlobalConstant.margin)
        separatorLineView.backgroundColor = UIColor.weatherSemiTransparent()
        separatorLineView.isHidden = false
    }
}
