//
//  DetailCharacterViewController.swift
//  Wallamarvel
//
//  Created by Samuel Hervás on 25/2/16.
//  Copyright © 2016 Samuel Hervás Gómez. All rights reserved.
//

import UIKit

class DetailCharacterViewController: UIViewController {
    
    @IBOutlet var descriptionView: UITextView!
    @IBOutlet var nameView: UILabel!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var thumbnailImage: UIImageView!
    
    var character : Character! {
        didSet{
            updateViewWithCharacter(character)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if character != nil {
            updateViewWithCharacter(character)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func updateViewWithCharacter(character: Character) -> Void {
        guard let descriptionView = self.descriptionView
            else {
                return
            }
        
        if let description = character.description {
            descriptionView.text = (description.isEmpty) ? "No description" : description;
        }
        
        if let name = character.name {
            nameView.text = name
        }
        if let image = CacheManger.sharedInstance.imageCache.objectForKey(character.id) as? UIImage {
            updateCharacterImage(image)
            return;
        }
        
        let urlString = character.thumbnail.path + "." + character.thumbnail.fileExtension
        if let url = NSURL(string:urlString ) {
            HTTPClient.sharedInstance.downloadThumbnail(url, id: character.id, completionHandler: { (thumbnail) -> Void in
                if let thumb = thumbnail {
                    CacheManger.sharedInstance.imageCache.setObject(thumb, forKey: character.id)
                    self.updateCharacterImage(thumb)
                }
            })
        }
    }
    
    func updateCharacterImage(image: UIImage) -> Void {
        self.backgroundImage.image = image
        self.thumbnailImage.image = image
        self.thumbnailImage.layer.cornerRadius = self.thumbnailImage.frame.width/2
        self.thumbnailImage.clipsToBounds = true
    }
}
