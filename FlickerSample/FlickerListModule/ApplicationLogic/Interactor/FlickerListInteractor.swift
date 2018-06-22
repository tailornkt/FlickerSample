//
//  FlickerListInteractor.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import Foundation

protocol FlickerPhotoInteractorInput: class {
    func fetchPhotosFromServer(_ pageNumber: Int,searchText:String)
}

protocol FlickerPhotoInteractorOutput: class {
    func photosFetched(photos: [[PhotoModel]])
    func fetchError(error : Error)
}
class ListInteractor :FlickerPhotoInteractorInput {
    
    var flickerApi:FlickerListApiInterface?
    weak var output: FlickerPhotoInteractorOutput!

    init(flickergateway: FlickerListApiInterface) {
        self.flickerApi = flickergateway
    }
    
    func fetchPhotosFromServer(_ pageNumber: Int,searchText:String) {
        self.flickerApi?.fetchFlickerPhotos(pageNumber,searchText: searchText,onSuccess: { (array) in
            self.output.photosFetched(photos: array as! [[PhotoModel]])
        }, onFail: { (error) in
            self.output.fetchError(error: error)
        })
    }
}
