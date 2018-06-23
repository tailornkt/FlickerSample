//
//  FlickerListApiInterface.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 20/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//  Purpose: This Protocol is a blue print for Flicker photo download process

import Foundation

// typealias of success and error block
typealias FetchFlickerPhotosListOnSuccess = (_ books: Array<Any>) -> Void
typealias FetchFlickerPhotosListOnFail = (_ error: Error) -> Void

protocol FlickerListApiInterface {
    /**
     * Summary: fetchFlickerPhotos:
     * Blue print method to fetch image from server.
     *
     * @param $pageNumber: page number for paging in app
     * @param $searchText: it's used to get search text based result
     * @param $onSuccess: success block to get success result
     * @param $onFail: failed block to get failed event
     * @return:
     */
    func fetchFlickerPhotos(_ pageNumber: Int,searchText:String,onSuccess: @escaping FetchFlickerPhotosListOnSuccess,onFail: @escaping FetchFlickerPhotosListOnFail)
}
