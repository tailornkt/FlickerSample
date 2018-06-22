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

    }
    
    func testGetPhotoList()  {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Download apple.com home page")
        
        // Create a URL for a web page to be downloaded.
        let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=2&safe_search=1&text=kittens&per_page=100&page=1")!
        
        self.listViewController.viewDidLoad()
        // Create a background task to download the web page.
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            // Make sure we downloaded some data.
            XCTAssertNotNil(data, "No data was downloaded.")
            
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
             print("photo",self.listViewController.photos)
        }
        
        // Start the download task.
        dataTask.resume()
        
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 5.0)
        
       print("photo",self.listViewController.photos)
       
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
