//
//  ExtendedInfoCell.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//
import LBTAComponents

class ExtendedInfoCell: DatasourceCell, UICollectionViewDelegateFlowLayout {
    
    lazy var cellCollectionView: DatasourceCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: GlobalConstant.margin, bottom: 0, right: GlobalConstant.margin)
        let cv = DatasourceCollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.isScrollEnabled = false
        cv.delegate = self
        return cv
    }()
    
    override var datasourceItem: Any? {
        didSet{
            guard let weatherExtendedInfo = datasourceItem as? WeatherDaily else { return }
            let extendedInfoDatasource = ExtendedInfoDatasource(weatherExtendedInfo: weatherExtendedInfo)
            cellCollectionView.datasource = extendedInfoDatasource
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(cellCollectionView)
        cellCollectionView.fillSuperview()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width - 2 * GlobalConstant.margin) / 2, height: WeatherCells.extendedInfo.defaultHeight)
    }
}


