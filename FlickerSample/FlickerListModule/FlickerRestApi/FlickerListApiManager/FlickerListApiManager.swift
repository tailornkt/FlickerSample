//
//  FlickerListApiManager.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 20/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import Foundation

class FlickerListApiManager: FlickerListApiInterface {
    
    let restApiRequest: RestApiRequest
    
    init(apiClient: RestApiRequest) {
        self.restApiRequest = apiClient
    }

    func fetchFlickerPhotos(_ pageNumber: Int, searchText: String,onSuccess: @escaping FetchFlickerPhotosListOnSuccess, onFail: @escaping FetchFlickerPhotosListOnFail) {
        let flickerListApiRequest = FlickerListApiRequest(searchText, pageNumber: pageNumber)
        self.restApiRequest.makeRestApiRequest(request: flickerListApiRequest, onSuccess: { (response) in
            guard let data = response.data,
                let jsonObject = try? JSONSerialization.jsonObject(with: data),
                let json = jsonObject as? NSDictionary else {
                     onFail(NSError.createPraserError())
                    return
                    }
            if let stat = json.value(forKey: "stat") as? String,stat.lowercased() == "ok" {

                    if let photos = json.value(forKeyPath: "photos.photo") as? Array<AnyObject> {
                        var dataArr : Array<Array<PhotoModel>> = []
                        var tempArr : Array<PhotoModel> = []
                            var index = 0
                            for data in photos {
                                if let model =  PhotoModel(json: data as? [String : Any]) {
                                    if index < 3 {
                                      tempArr.append(model)
                                      index += 1
                                    }else {
                                        dataArr.append(tempArr)
                                        tempArr = []
                                        index = 0
                                    }
                                }
                            }
                        if !tempArr.isEmpty {
                           dataArr.append(tempArr)
                        }
                            onSuccess(dataArr)
                    }else {
                        onFail(NSError.createPraserError())
                    }
            }else {
                onFail(NSError.createPraserError())
            }
            
        }) { (error) in
           onFail(error)
        }
    }
}

