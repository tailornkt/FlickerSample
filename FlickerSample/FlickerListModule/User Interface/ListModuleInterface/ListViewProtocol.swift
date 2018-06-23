//
//  ListInteractorProtocol.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//  Purpose: It is blue print method for viewcontroller , it communicates between viewcontroller and presenter 

import Foundation
/**
 * Summary: IndicatableView:
 * Blue print methods to show and hide interactor.
 */
protocol IndicatableView: class {
    /**
     * Summary: showActivityIndicator:
     * It's blue print method to show activity indicator on view
     * @return:
     */
    func showActivityIndicator()
    /**
     * Summary: hideActivityIndicator:
     * It's blue print method to hide activity indicator on view
     * @return:
     */
    func hideActivityIndicator()
}
protocol ListViewProtocol:IndicatableView {
    /**
     * Summary: getPhotoList:
     * It's blue print method to get photoList from presenter to viewcontroller
     * @return:
     */
    func getPhotoList(photos: [[PhotoModel]])
    /**
     * Summary: showNoResultAlert:
     * It's blue print method to show empty view
     * @return:
     */
    func showNoResultAlert()
    /**
     * Summary: hideTableView:
     * It's blue print method to hide table view in the case of no result from server
     * @return:
     */
    func hideTableView()
    /**
     * Summary: showTableView:
     * It's blue print method to show table view
     * @return:
     */
    func showTableView()
    /**
     * Summary: setNavigationTitle:
     * It's blue print method to show navigation title
     * @return:
     */
    func setNavigationTitle(_ title: String)
}
