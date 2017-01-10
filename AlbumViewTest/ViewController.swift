//
//  ViewController.swift
//  AlbumViewTest
//
//  Created by sazzad on 1/9/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//

import UIKit
import Photos

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        grabPhoto()
    }
        func grabPhoto(){
        let imgManager = PHImageManager.default()
        let requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
        requestOption.deliveryMode = .highQualityFormat
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult : PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOption)
        if fetchResult.count > 0 {
            for i in 0..<fetchResult.count {
                imgManager.requestImage(for: fetchResult.object(at: i) , targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOption, resultHandler: ({
                    [weak self] image , error in
                        self?.imageArray.append(image!)
                    
                }))
            }
        }else {
            print("No photo found")
            self.collectionView?.reloadData()
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = imageArray[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 1
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    


}

