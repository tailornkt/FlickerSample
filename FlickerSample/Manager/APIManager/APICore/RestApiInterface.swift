//
//  RestApiInterface.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 20/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//  Purpose: It is blue print method for Rest api request 

import Foundation
/**
 * Summary: RestApiUrlRequest:
 * It's blue print method, used to make api request with custome parameters
 * @return:
 */
protocol RestApiUrlRequest {
    /**
     * Summary: apiUrlRequest:
     * It's used to create URLRequest
     * @return: URLRequest
     */
    var apiUrlRequest : URLRequest { get }
}
/**
 * Summary: RestApiUrlRequest:
 * It's blue print method, used to make api hit with remote server 
 * @return:
 */
protocol RestApiRequest {
    /**
     * Summary: makeRestApiRequest:
     * It's used to call rest api request with URLSession
     *
     * @param $request: it is URLRequest
     * @param $onSuccess: show success result onsuccess block
     * @param $onFail: show failed result onFail block
     * @return:URLSessionDataTask
     */
    func makeRestApiRequest(request : RestApiUrlRequest, onSuccess: @escaping (_ result: RestApiResponse) -> Void, onFail:@escaping (_ error: Error) -> Void) -> URLSessionDataTask
}
