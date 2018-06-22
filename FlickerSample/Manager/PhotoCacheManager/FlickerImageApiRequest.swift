//
//  FlickerImageApiRequest.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import Foundation

struct FlickerImageApiRequest: RestApiUrlRequest {
    
    var imgUrl : URL?
    init(_ url : URL) {
        self.imgUrl = url
    }
    
    var apiUrlRequest: URLRequest {
        var request = URLRequest(url: imgUrl!)
        request.setValue("application/vnd.fortech.books-list+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        return request
    }
}
