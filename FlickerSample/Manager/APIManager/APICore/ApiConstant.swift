//
//  ApiConstant.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import Foundation
import UIKit
//https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&%20format=json&nojsoncallback=1&safe_search=1&text=kittens&per_page=10&page=2



let kFlickerApiBaseURL                    = "https://api.flickr.com/services/rest/"


let KFlickerPageLimit                       = 100

/* Flicker API keys */
let KFlickeryAPIKey:String             = "3e7cc266ae2b0e0d78e279ce8e361736"

struct ScreenSize {
    static let kWidth:CGFloat = UIScreen.main.bounds.size.width
    static let kHeight:CGFloat = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.kWidth, ScreenSize.kHeight)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.kWidth, ScreenSize.kHeight)
    
}
