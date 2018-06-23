//
//  FlickerListPresenter.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//  Purpose: It is presenter , it communicates between interactor and view

import Foundation
/**
 * Summary: ListPresenterPresentation:
 * Blue print methods for presenter
 */
protocol ListPresenterPresentation: class {
    weak var view: ListViewProtocol? { get set }
    var interactor: FlickerPhotoInteractorInput! { get set }
    /**
     * Summary: viewDidLoad:
     * It's blue print method to handle view load process in presenter
     *
     * @param $searchText: take search text in initial load to take search result from server
     * @return:
     */
    func viewDidLoad(_ searchText : String?)
    /**
     * Summary: fetchDataFromServer:
     * It's blue print method to get result from server as per pagenumber in request
     *
     * @param $pageNumber: it is used to implement paging
     * @return:
     */
    func fetchDataFromServer(_ pageNumber : Int)
}

class FlickerListPresenter : ListPresenterPresentation {
    
    var searchKeyword : String = "kittens"
    var view: ListViewProtocol?
    
    var interactor: FlickerPhotoInteractorInput!
    
    var photos: [[PhotoModel]] = [] {
        didSet {
            if photos.count > 0 {
                view?.getPhotoList(photos: photos)
            } else {
                view?.showNoResultAlert()
                // hide empty tanble
            }
        }
    }
    /**
     * Summary: viewDidLoad:
     * It's used to handle view load process in presenter
     *
     * @param $searchText: take search text in initial load to take search result from server
     * @return:
     */
    func viewDidLoad(_ searchText : String?) {
        if let text = searchText {
            self.searchKeyword = text
        }
        view?.setNavigationTitle(self.searchKeyword)
        self.fetchDataFromServer(1)
        view?.showActivityIndicator()
    }
    /**
     * Summary: fetchDataFromServer:
     * It's used to get result from server as per pagenumber in request
     *
     * @param $pageNumber: it is used to implement paging
     * @return:
     */
    func fetchDataFromServer(_ pageNumber: Int) {
        interactor.fetchPhotosFromServer(pageNumber, searchText: self.searchKeyword)
    }
}
/**
 * Summary: FlickerListPresenter:
 * It is FlickerListPresenter extension, used to implement FlickerPhotoInteractorOutput
 */
extension FlickerListPresenter: FlickerPhotoInteractorOutput {
    func photosFetched(photos: [[PhotoModel]]) {
        self.photos = photos
        view?.hideActivityIndicator()
    }
    
    func fetchError(error: Error) {
        view?.hideTableView()
        view?.hideActivityIndicator()
    }
}
