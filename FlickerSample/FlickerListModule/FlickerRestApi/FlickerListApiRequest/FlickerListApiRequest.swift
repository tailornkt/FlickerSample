//
//  FlickerListApiRequest.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 20/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import Foundation

struct FlickerListApiRequest: RestApiUrlRequest {
    
    var searchText : String?
    var pageNumber : Int?
    
    init(_ searchText:String,pageNumber:Int) {
        self.searchText = searchText
        self.pageNumber = pageNumber
    }
  
    let KFlickerPhotosSearchEndpoint                                = "flickr.photos.search"
    
    var apiUrlRequest: URLRequest {
        //https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&%20format=json&nojsoncallback=2&safe_search=1&text=kittens&per_page=10&page=2
        let pageNumber = String(describing: self.pageNumber!)
        let limit = String(describing: KFlickerPageLimit)
        let searchPerPage = "&text=" + self.searchText! + "&per_page=" + limit + "&page=" + pageNumber
        let apiEndPoint = kFlickerApiBaseURL + "?method=" + KFlickerPhotosSearchEndpoint
        let urlString = apiEndPoint + "&api_key=" + KFlickeryAPIKey + "&format=json&nojsoncallback=2&safe_search=1" + searchPerPage
        print(urlString)
        let url: URL! = URL(string: urlString)
        var request = URLRequest(url: url)
        
        request.setValue("application/vnd.fortech.books-list+json", forHTTPHeaderField: "Accept")
        
        request.httpMethod = "GET"
        
        return request
    }
}
