//
//  FlickerListInteractor.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//  Purpose: It is Interactor to communicated with entity and presenter

import Foundation


/**
 * Summary: FlickerPhotoInteractorInput:
 * It's act as Interactor Input taking input from presenter.
 */
protocol FlickerPhotoInteractorInput: class {
    /**
     * Summary: fetchPhotosFromServer:
     * It's blue print method to take input from presenter.
     *
     * @param $pageNumber: page number for paging
     * @param $searchText: search text for user specified search result
     * @return:
     */
    func fetchPhotosFromServer(_ pageNumber: Int,searchText:String)
}

/**
 * Summary: FlickerPhotoInteractorOutput:
 * It's act as Interactor Output responding back to presenter.
 */
protocol FlickerPhotoInteractorOutput: class {
    /**
     * Summary: photosFetched:
     * It's blue print method to responed back to presenter with fetched photos model
     *
     * @param $photos: 2D Array of Photomodel
     * @return:
     */
    func photosFetched(photos: [[PhotoModel]])
    /**
     * Summary: fetchError:
     * It's blue print method to responed back api error to presenter
     *
     * @param $error: Custome Error while fetching data
     * @return:
     */
    func fetchError(error : Error)
}
/**
 * Summary: ListInteractor:
 * It is Interactor to communicated with entity and presenter.
 */
class ListInteractor :FlickerPhotoInteractorInput {
    
    var flickerApi:FlickerListApiInterface?
    weak var output: FlickerPhotoInteractorOutput!
    /**
     * Summary: init:
     * It's constructor method to create Interactor reference
     *
     * @param $flickergateway: flicker apiinterface s
     * @return:
     */
    init(flickergateway: FlickerListApiInterface) {
        self.flickerApi = flickergateway
    }
    /**
     * Summary: fetchPhotosFromServer:
     * It's used to make api call with pagenumber and searchtext
     *
     * @param $pageNumber: it is used for paging
     * @param $searchText: searchtext used to get user specified search result
     * @return:
     */
    func fetchPhotosFromServer(_ pageNumber: Int,searchText:String) {
        self.flickerApi?.fetchFlickerPhotos(pageNumber,searchText: searchText,onSuccess: { (array) in
            self.output.photosFetched(photos: array as! [[PhotoModel]])
        }, onFail: { (error) in
            self.output.fetchError(error: error)
        })
    }
}
