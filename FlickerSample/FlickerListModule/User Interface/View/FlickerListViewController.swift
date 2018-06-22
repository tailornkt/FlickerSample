//
//  ViewController.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 19/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isDownloadInProgress = true
        self.registerCustomeCell()
        self.configureFlickerModule()
        self.setupSearchController()
        self.presenter?.viewDidLoad(nil)
    }
    
    func setupSearchController()  {
        // Setup the Search Controller
        //searchController.searchResultsUpdater = self
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
    
    func configureFlickerModule()  {
        let apiClient = RestApiManager(sessionConfiguration: URLSessionConfiguration.default,
                                       operationQueue: OperationQueue.main)
        let apiRequestManager = FlickerListApiManager(apiClient: apiClient)
        
        self.presenter = FlickerListPresenter()
        self.presenter?.view = self
        let listInteractor = ListInteractor(flickergateway: apiRequestManager)
        listInteractor.output = presenter as! FlickerPhotoInteractorOutput
        
        presenter?.interactor = listInteractor
        //  listPresenter.listWireframe = listWireframe
        
    }
    
    func registerCustomeCell()  {
        self.tableView?.register(UINib(nibName: "FlickerPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: kCellIdentifier)
    }
}

extension FlickerListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier)
        //(cell as? FlickerPhotoTableViewCell)?.lblCount.text = String(indexPath.row)
        if indexPath.row >= (self.photos.count - (self.photos.count/2)) && !self.isDownloadInProgress {
            self.isDownloadInProgress = true
            pageNumber += 1
            self.presenter?.fetchDataFromServer(pageNumber)
        }
        (cell as? FlickerPhotoTableViewCell)?.setupData(self.photos[indexPath.row])
        cell?.selectionStyle = .none
        return cell!
    }
}

extension FlickerListViewController: UISearchBarDelegate {
    
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

extension FlickerListViewController : ListViewProtocol {
    
    func hideTableView() {
        self.tableView?.isHidden = true
    }
    func showTableView() {
        self.tableView?.isHidden = false
    }
    
    func getPhotoList(photos: [[PhotoModel]]) {
        self.showTableView()
        self.photos.append(contentsOf: photos)
    }
    
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
    func showActivityIndicator() {
        self.activityIndicatorView?.isHidden = false
       self.activityIndicatorView?.startAnimating()
    }
    func hideActivityIndicator() {
         self.activityIndicatorView?.isHidden = true
        self.activityIndicatorView?.stopAnimating()
    }
    func setNavigationTitle(_ title: String) {
        self.title = title
    }
}
