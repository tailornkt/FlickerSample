//
//  RestAPICore.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 20/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//  Purpose: It is blue print method for Rest api integration

import Foundation
/**
 * Summary: RestApiNetworkRequestError:
 * It's used to show custome Request error
 * @return:
 */
struct RestApiNetworkRequestError: Error {
    let error: Error?
    
    var localizedDescription: String {
        return error?.localizedDescription ?? "Network request error"
    }
}
/**
 * Summary: RestApiError:
 * It's used to show Rest api error
 * @return:
 */
struct RestApiError: Error {
    let data: Data?
    let httpUrlResponse: HTTPURLResponse
}
/**
 * Summary: RestApiParserError:
 * It's used to show Rest api parser error
 * @return:
 */
struct RestApiParserError: Error {
    static let code = 555
    
    let error: Error
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    var localizedDescription: String {
        return error.localizedDescription
    }
}
/**
 * Summary: RestApiResponse:
 * It's used to show Rest api response
 * @return:
 */
struct RestApiResponse {
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) {
        self.httpUrlResponse = httpUrlResponse
        self.data = data
    }
}
/**
 * Summary: NSError:
 * It's NSError extension to create custome error
 * @return:
 */
extension NSError {
    static func createPraserError() -> NSError {
        return NSError(domain: "com.ravi.flicker",
                       code: RestApiParserError.code,
                       userInfo: [NSLocalizedDescriptionKey: "Data parsing error occured"])
    }
}
