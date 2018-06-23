//
//  ViewController.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 19/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
// Purpose: It is viewcontroller, managing all life cycle of viewcontroller 

import UIKit

let FlickerListViewControllerIdentifier = "FlickerListViewControllerID"

class FlickerListViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    let kCellIdentifier = "FlickerPhotoTableViewCell"
    let searchController = UISearchController(searchResultsController: nil)
    var isDownloadInProgress : Bool = false
    var pageNumber : Int = 1
    var presenter : ListPresenterPresentation?
    var photos: [[PhotoModel]] = [] {
        didSet {
            self.tableView?.reloadData {
                self.isDownloadInProgress = false
            }
        }
    }
    /**
     * Summary: viewDidLoad:
     * It's used to initialize code after view load, make a first hit with default search text kitten
     * @return:
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isDownloadInProgress = true
        self.registerCustomeCell()
        self.configureFlickerModule()
        self.setupSearchController()
        self.presenter?.viewDidLoad(nil)
    }
    /**
     * Summary: setupSearchController:
     * It's used to set search controller in navigation bar
     * @return:
     */
    func setupSearchController()  {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search your favourite"
        definesPresentationContext = false
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
            self.searchController.hidesNavigationBarDuringPresentation = false
            self.searchController.searchBar.searchBarStyle = UISearchBarStyle.minimal
            self.navigationItem.titleView = self.searchController.searchBar
        }
    }
    /**
     * Summary: configureFlickerModule:
     * It's used to initialize code for basic configuration for VIPER Module
     * @return:
     */
    func configureFlickerModule()  {
        let apiClient = RestApiManager(sessionConfiguration: URLSessionConfiguration.default,
                                       operationQueue: OperationQueue.main)
        let apiRequestManager = FlickerListApiManager(apiClient: apiClient)
        
        self.presenter = FlickerListPresenter()
        self.presenter?.view = self
        let listInteractor = ListInteractor(flickergateway: apiRequestManager)
        listInteractor.output = presenter as! FlickerPhotoInteractorOutput
        
        presenter?.interactor = listInteractor
        
    }
    /**
     * Summary: registerCustomeCell:
     * It's used to register cell for tableview
     * @return:
     */
    func registerCustomeCell()  {
        self.tableView?.register(UINib(nibName: "FlickerPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: kCellIdentifier)
    }
}
/**
 * Summary: It is extension of FlickerListViewController
 * It's used to implement tableview delegate and datasource:
 * @return:
 */
extension FlickerListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier)
        (cell as? FlickerPhotoTableViewCell)?.setupData(self.photos[indexPath.row])
        let count = (self.photos.count - (self.photos.count/2))
        self.loadNextPageData(indexPath, isInProcess: self.isDownloadInProgress, count: count)
        cell?.selectionStyle = .none
        return cell!
    }
    
    func loadNextPageData(_ indexPath: IndexPath,isInProcess:Bool,count:Int)  {
        if indexPath.row >= count && !isInProcess {
            self.isDownloadInProgress = true
            pageNumber += 1
            self.presenter?.fetchDataFromServer(pageNumber)
        }
    }
}
/**
 * Summary: It is extension of FlickerListViewController
 * It's used to implement UISearchBarDelegate delegate:
 * @return:
 */
extension FlickerListViewController: UISearchBarDelegate {
    /**
     * Summary: searchBarSearchButtonClicked:
     * It's used to handle search bar delegate and make search result with search text
     * @return:
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.hideTableView()
        pageNumber = 1
        self.photos.removeAll()
        self.isDownloadInProgress = true
        self.presenter?.viewDidLoad(searchBar.text)
        searchBar.text = nil
        self.searchController.isActive = false
    }
}
/**
 * Summary: It is extension of FlickerListViewController
 * It's used to implement ListViewProtocol:
 * @return:
 */
extension FlickerListViewController : ListViewProtocol {
    /**
     * Summary: showTableView:
     * It's used to show table view
     * @return:
     */
    func hideTableView() {
        self.tableView?.isHidden = true
    }
    func showTableView() {
        self.tableView?.isHidden = false
    }
    /**
     * Summary: getPhotoList:
     * It's used to get photoList from presenter to viewcontroller
     * @return:
     */
    func getPhotoList(photos: [[PhotoModel]]) {
        self.showTableView()
        self.photos.append(contentsOf: photos)
    }
    /**
     * Summary: showNoResultAlert:
     * It is used to show alert of no result
     * @return:
     */
    func showNoResultAlert() {
        let alert = UIAlertController(
            title: "No Result Found",
            message: nil,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "Ok",
            style: .default,
            handler: nil
        ))
        
        self.present(alert, animated: true, completion: nil)
    }
    /**
     * Summary: showActivityIndicator:
     * It's used to show activity indicator on view
     * @return:
     */
    func showActivityIndicator() {
        self.activityIndicatorView?.isHidden = false
        self.activityIndicatorView?.startAnimating()
    }
    /**
     * Summary: hideActivityIndicator:
     * It's used to hide activity indicator on view
     * @return:
     */
    func hideActivityIndicator() {
        self.activityIndicatorView?.isHidden = true
        self.activityIndicatorView?.stopAnimating()
    }
    /**
     * Summary: setNavigationTitle:
     * It's used to show navigation title
     * @return:
     */
    func setNavigationTitle(_ title: String) {
        self.title = title
    }
}
