//
//  FlickerListApiInterface.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 20/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import Foundation

typealias FetchFlickerPhotosListOnSuccess = (_ books: Array<Any>) -> Void
typealias FetchFlickerPhotosListOnFail = (_ error: Error) -> Void

protocol FlickerListApiInterface {
    func fetchFlickerPhotos(_ pageNumber: Int,searchText:String,onSuccess: @escaping FetchFlickerPhotosListOnSuccess,onFail: @escaping FetchFlickerPhotosListOnFail)
}
