//
//  ListViewControllerTest.swift
//  FlickerSampleTests
//
//  Created by Ravi Tailor on 22/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import XCTest

@testable import FlickerSample

class ListViewControllerTest: XCTestCase {
    
    var listViewController : FlickerListViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.listViewController = storyboard.instantiateViewController(withIdentifier: FlickerListViewControllerIdentifier) as! FlickerListViewController
        self.listViewController.loadViewIfNeeded()

    }
    
    func testGetPhotoList()  {
        self.listViewController.getPhotoList(photos: [])
        XCTAssertEqual(self.listViewController.photos.count, 0)
       
    }
    
    func testFirstApiCallInViewDidLoad()  {
        self.listViewController.viewDidLoad()
        XCTAssertEqual(self.listViewController.isDownloadInProgress, true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPaging() {
        for var i in 1 ... 3 {
            let count = (self.listViewController.photos.count - (self.listViewController.photos.count/2))
            let indexPath = IndexPath(row: (8*i), section: 0)
           self.listViewController.loadNextPageData(indexPath, isInProcess:false, count: count)
            wait(for: [], timeout: 10.0)
            i += 1
            if i > 3 {
                print("total count",self.listViewController.photos.count)
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
