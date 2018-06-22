//
//  FlickerPhotoTableViewCell.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//

import UIKit

class FlickerPhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    let cellIdentifier = "CollectionImageViewCell"
    var photoArray : Array<PhotoModel> = []
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.register( UINib(nibName: "CollectionImageViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
  
    func setupData(_ array : Array<PhotoModel>)  {
        self.photoArray = array
        self.collectionView.reloadData()
    }
}
extension FlickerPhotoTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.photoArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CollectionImageViewCell
        let data = self.photoArray[indexPath.row]
        (cell as? CollectionImageViewCell)?.setupData(data)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let returnValue =  CGSize(width:(ScreenSize.kWidth/3), height: 99.0)
        return returnValue
    }
}
