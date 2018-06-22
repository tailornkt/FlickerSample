//
//  ListInteractorProtocol.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import Foundation

protocol IndicatableView: class {
    func showActivityIndicator()
    func hideActivityIndicator()
}
protocol ListViewProtocol:IndicatableView {
    
    func getPhotoList(photos: [[PhotoModel]])
    func showNoResultAlert()
    func hideTableView()
    func showTableView()
    func setNavigationTitle(_ title: String)
}
