//
//  FlickerImageCacheManager.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import Foundation
import UIKit

class FlickerImageCache {
    static private var cachedKeys = [String]()
    static let sharedNSCache: NSCache<NSString, UIImage> = {
        let nsCache = NSCache<NSString, UIImage>()
        nsCache.name = "FlickerImageCache"
        nsCache.countLimit = 1000
        nsCache.totalCostLimit = 5*1024*1024
        return nsCache
    }()
}

class FlickerImgDownloader {
    static func downloadFlickerImage(urlString: String, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        if let image = FlickerImageCache.sharedNSCache.object(forKey: (urlString as NSString)) {
            print("fetched image from nscache ...")
            completion(image)
            return nil
        } else {
            guard let url = URL(string: urlString) else {
                completion(nil)
                return nil
            }
            let apiClient = RestApiManager(sessionConfiguration: URLSessionConfiguration.default,
                                           operationQueue: OperationQueue.main)
            let apiRequestManager = FlickerImageApiManager(apiClient: apiClient)
            let dataTask = apiRequestManager.loadImageFromURL(url, completion: { (result) in
                switch result {
                case .success(let image):
                    completion(image)
                case .failure(let errorMessage):
                    print("fetch failed : \(errorMessage)")
                }
            })
            
            return dataTask
        }
    }
}
