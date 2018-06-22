//
//  RestApiInterface.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 20/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import Foundation

protocol RestApiUrlRequest {
    var apiUrlRequest : URLRequest { get }
}

protocol RestApiRequest {
    func makeRestApiRequest(request : RestApiUrlRequest, onSuccess: @escaping (_ result: RestApiResponse) -> Void, onFail:@escaping (_ error: Error) -> Void) -> URLSessionDataTask
}
