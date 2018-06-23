//
//  FlickerImageApiManager.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//  Purpose: It is used to download image from remote server 

import Foundation
import UIKit

enum Result<T> {
    case success(T)
    case failure(String)
}

class FlickerImageApiManager {
    
    let restApiRequest: RestApiRequest
    /**
     * Summary: init:
     * It's used to initialzed FlickerImageApiManager
     *
     */
    init(apiClient: RestApiRequest) {
        self.restApiRequest = apiClient
    }
    /**
     * Summary: loadImageFromURL:
     * It's used to call download image with the help of RestApiManager
     *
     * @param $url: Request url of image
     * @param $completion: show success and failure in completion block
     * @return:URLSessionDataTask
     */
    func loadImageFromURL(_ url: URL, completion: @escaping (Result<UIImage>) -> Void) -> URLSessionDataTask {
        let imageRequest = FlickerImageApiRequest(url)
        let dataTask =  self.restApiRequest.makeRestApiRequest(request: imageRequest, onSuccess: { (response) in
            
            guard let data = response.data, let image = UIImage.init(data: data) else {
                completion(.failure("Invalid response"))
                return
            }
            
            FlickerImageCache.sharedNSCache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }) { (error) in
            completion(.failure("Invalid response"))
        }
        return dataTask
    }
}
