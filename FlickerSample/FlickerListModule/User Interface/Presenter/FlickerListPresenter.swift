//
//  FlickerListPresenter.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import Foundation

protocol ListPresenterPresentation: class {
    weak var view: ListViewProtocol? { get set }
    var interactor: FlickerPhotoInteractorInput! { get set }
    //var router: ArticlesWireframe! { get set }
    func viewDidLoad(_ searchText : String?)
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
    
    func viewDidLoad(_ searchText : String?) {
        if let text = searchText {
          self.searchKeyword = text
        }
        view?.setNavigationTitle(self.searchKeyword)
        self.fetchDataFromServer(1)
        view?.showActivityIndicator()
    }
    
    func fetchDataFromServer(_ pageNumber: Int) {
        interactor.fetchPhotosFromServer(pageNumber, searchText: self.searchKeyword)
    }
}

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
