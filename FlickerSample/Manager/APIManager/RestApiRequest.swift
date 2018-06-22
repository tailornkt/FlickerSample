//
//  RestApiRequest.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 20/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import Foundation

class RestApiManager: RestApiRequest {
    let urlSession : URLSession
    
    init(sessionConfiguration: URLSessionConfiguration, operationQueue : OperationQueue) {
        urlSession = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: operationQueue)
    }
    
    func makeRestApiRequest(request: RestApiUrlRequest, onSuccess: @escaping (RestApiResponse) -> Void, onFail: @escaping (Error) -> Void) -> URLSessionDataTask {
        let dataTask  = urlSession.dataTask(with: request.apiUrlRequest) { (data, response, error) in
            
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                onFail(RestApiNetworkRequestError(error: error))
                return
            }
            
            let successRange = 200...299
            if successRange.contains(httpUrlResponse.statusCode) {
                onSuccess(RestApiResponse(data: data, httpUrlResponse: httpUrlResponse))
            } else {
                onFail(RestApiError(data: data, httpUrlResponse: httpUrlResponse))
            }
        }
        dataTask.resume()
        
        return dataTask
    }
}
