//
//  FlickerImageApiRequest.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//  Purpose: It is used to create api request for image

import Foundation

struct FlickerImageApiRequest: RestApiUrlRequest {
    
    var imgUrl : URL?
    init(_ url : URL) {
        self.imgUrl = url
    }
    /**
     * Summary: apiUrlRequest:
     * It's variable for apiUrlRequest
     */
    var apiUrlRequest: URLRequest {
        var request = URLRequest(url: imgUrl!)
        request.setValue("application/vnd.fortech.books-list+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        return request
    }
}
