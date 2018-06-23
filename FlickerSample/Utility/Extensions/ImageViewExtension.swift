//
//  ImageViewExtension.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//  Purpose: This ImageView Extension used to download image in background process

import Foundation
import UIKit

extension UIImageView {
    /**
     * Summary: imageFromServerURL:
     * This method is used to download image data from server in background process.
     *
     * @param $urlString: remote image url
     *
     * @return:
     */
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}
