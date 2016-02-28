//
//  CharacterCollectionDataSource.swift
//  Wallamarvel
//
//  Created by Samuel Hervás on 24/2/16.
//  Copyright © 2016 Samuel Hervás Gómez. All rights reserved.
//

import UIKit
import Alamofire

public class CharacterCollectionDataSource : NSObject, UICollectionViewDataSource {
    
    public var characters : [Character]?
    public var filterKeyword : String?
    public var filterCharacter : [Character]? {
        get {
            if let keyword = filterKeyword {
                return self.characters?.filter({ (element) -> Bool in
                    return element.name.containsString(keyword)
                })
            } else {
                return self.characters
            }
        }
    }
    
    @objc public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = self.filterCharacter?.count {
            return count
        }
        return 0
    }
    
    @objc public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("characterCollectionCell", forIndexPath: indexPath) as! CharacterCollectionViewCell
        
        let currentCharacter = filterCharacter![indexPath.row]
        if let image = CacheManger.sharedInstance.imageCache.objectForKey(currentCharacter.id) as? UIImage {
            cell.setupCellForCharacter(currentCharacter, image: image)
        } else {
            cell.setupCellForCharacter(currentCharacter, image: nil)
            
            let urlString = currentCharacter.thumbnail.path + "." + currentCharacter.thumbnail.fileExtension
            if let url = NSURL(string:urlString ) {
                HTTPClient.sharedInstance.downloadThumbnail(url, id: currentCharacter.id, completionHandler: { (thumbnail) -> Void in
                    if let thumb = thumbnail {
                        CacheManger.sharedInstance.imageCache.setObject(thumb, forKey: currentCharacter.id)
                        collectionView.reloadData()
                    }
                })
            }
        }
        
        return cell
    }
}