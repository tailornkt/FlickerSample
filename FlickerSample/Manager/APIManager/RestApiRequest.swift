//
//  RestApiRequest.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 20/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//  Purpose: It is implementation of RestApiRequest blue print method 

import Foundation

class RestApiManager: RestApiRequest {
    let urlSession : URLSession
    /**
     * Summary: init:
     * It's used to initialize urlsession with default config
     *
     * @param $sessionConfiguration: default configuration
     * @param $operationQueue: operation queue
     */
    init(sessionConfiguration: URLSessionConfiguration, operationQueue : OperationQueue) {
        urlSession = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: operationQueue)
    }
    /**
     * Summary: makeRestApiRequest:
     * It's used to call rest api request with URLSession
     *
     * @param $request: it is URLRequest
     * @param $onSuccess: show success result onsuccess block
     * @param $onFail: show failed result onFail block
     * @return:URLSessionDataTask
     */
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
