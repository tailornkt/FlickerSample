//
//  RestAPICore.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 20/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import Foundation

struct RestApiNetworkRequestError: Error {
    let error: Error?
    
    var localizedDescription: String {
        return error?.localizedDescription ?? "Network request error"
    }
}

struct RestApiError: Error {
    let data: Data?
    let httpUrlResponse: HTTPURLResponse
}

struct RestApiParserError: Error {
    static let code = 555
    
    let error: Error
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    var localizedDescription: String {
        return error.localizedDescription
    }
}

struct RestApiResponse {
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) {
        self.httpUrlResponse = httpUrlResponse
        self.data = data
    }
}
extension NSError {
    static func createPraserError() -> NSError {
        return NSError(domain: "com.ravi.flicker",
                       code: RestApiParserError.code,
                       userInfo: [NSLocalizedDescriptionKey: "Data parsing error occured"])
    }
}
