//
//  FlickerPhotoTableViewCell.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//  Purpose: It is FlickerPhotoTableViewCell, used to show 3 image in a single row

import UIKit

class FlickerPhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let cellIdentifier = "CollectionImageViewCell"
    var photoArray : Array<PhotoModel> = []
    /**
     * Summary: awakeFromNib:
     * It's used to initialize code after loading nib in memory
     * @return:
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.register( UINib(nibName: "CollectionImageViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    /**
     * Summary: setupData:
     * It's used to setup data
     * @return:
     */
    func setupData(_ array : Array<PhotoModel>)  {
        self.photoArray = array
        self.collectionView.reloadData()
    }
}
/**
 * Summary: FlickerPhotoTableViewCell:
 * It's used to implement collectionview delegates and datasource
 * @return:
 */
extension FlickerPhotoTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    /**
     * Summary: collectionView:numberOfItemsInSection
     * It's used to return number of rows in a section
     * @return: image count in a single row
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.photoArray.count
        
    }
    /**
     * Summary: collectionView:cellForItemAt
     * It's used to return cell with collection view
     * @return: UICollectionViewCell
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CollectionImageViewCell
        let data = self.photoArray[indexPath.row]
        (cell)?.setupData(data)
        return cell ?? UICollectionViewCell()
    }
    /**
     * Summary: collectionView:sizeForItemAt
     * It's used to return size for collection view cell
     * @return: CGSize
     */
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let returnValue =  CGSize(width:(ScreenSize.kWidth/3), height: 99.0)
        return returnValue
    }
}
