//
//  ViewController.swift
//  GalleryImagesImportSample
//
//  Created by Rashida on 4/27/17.
//  Copyright © 2017 Rashida. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var asset = PHAsset()
    var imagesArray = [Any]()
    let assetcollection = PHAssetCollection()
    var fetchresult = PHFetchResult<AnyObject>()
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       // PHPhotoLibrary.shared().register(self as! PHPhotoLibraryChangeObserver)

        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: true)]
       // fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)

        
        fetchresult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions) as! PHFetchResult<AnyObject>
        
        let manager = PHCachingImageManager.default()//PHImageManager.default()
        let option = PHImageRequestOptions()
        
        option.isSynchronous = true
        
        fetchresult.enumerateObjects({ (obj, idx, bool) -> Void in
            
//            manager.requestImage(for: obj as! PHAsset, targetSize: CGSize.init(width: 100, height: 100), contentMode: .aspectFit, options: option) { (thumbnailImage, info) in
//                print("ddv :\(thumbnailImage),is：\(info)")
//                self.imagesArray.append(thumbnailImage)
//                print(self.imagesArray)
//                self.collectionView.reloadData()
//                
//            }
            
            manager.requestImage(for: obj as! PHAsset, targetSize: CGSize.init(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: { (thumbnailImage, info) in
                
                print(info)
                print("thumb nail image is \(thumbnailImage)")
                
                
                
            })
            
//            manager.requestImageData(for: obj as! PHAsset, options: option) { (imageData, resultString, imageorientation, result: [AnyHashable : Any]?) in
//                print("result:\(result)")
//                print("imageData:\(imageData)")
//                print("resultString:\(resultString)")
//                self.imagesArray.append(obj)
//                print(self.imagesArray)
//                print(self.imagesArray.count)
//
//                self.collectionView.reloadData()
//            }
            
        })
        
        
       collectionView.delegate = self
        collectionView.dataSource = self

}
 
    func getAssetThumbnail(asset:PHAsset) -> Void {
        
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        
        option.isSynchronous = true
        option.isNetworkAccessAllowed = true
        option.deliveryMode = .opportunistic
       // option.resizeMode = .exact
        

        
        manager.requestImageData(for: asset, options: option) { (imageData, resultString, imageorientation, result: [AnyHashable : Any]?) in
            print("result:\(result)")
            print("imageData:\(imageData)")
            print("resultString:\(resultString)")
            
            
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return imagesArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell :UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath)
        let imageview = cell.contentView.viewWithTag(1000) as! UIImageView
        
       imageview.image = UIImage(named: imagesArray[indexPath.row] as! String)
        return cell
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

