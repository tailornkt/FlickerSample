//
//  CollectionImageViewCell.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import UIKit

class CollectionImageViewCell: UICollectionViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imgView: UIImageView!
    var dataTask : URLSessionDataTask?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgView?.layer.cornerRadius = 5.0
        self.imgView?.layer.masksToBounds = true
    }
    
    func setupData(_ data : PhotoModel)  {
        self.imgView.image = nil
        self.activityIndicator.isHidden = false
        let url = "http://farm" + String(data.farm) + ".static.flickr.com/" + data.server + "/" + data.id + "_" + data.secret + ".jpg"
        self.activityIndicator.startAnimating()
       self.dataTask = FlickerImgDownloader.downloadFlickerImage(urlString: url) { (image) in
            self.activityIndicator.isHidden = true
            self.activityIndicator.startAnimating()
            guard let image = image else { return }
            DispatchQueue.main.async {
                 self.imgView.image = image
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgView.image = nil
        self.activityIndicator.isHidden = true
        self.activityIndicator.startAnimating()
        self.dataTask?.cancel()
    }
}
