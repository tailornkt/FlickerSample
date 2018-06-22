//
//  FlickerImageApiManager.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import Foundation
import UIKit

enum Result<T> {
    case success(T)
    case failure(String)
}

class FlickerImageApiManager {
    
    let restApiRequest: RestApiRequest
    
    init(apiClient: RestApiRequest) {
        self.restApiRequest = apiClient
    }
    
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
