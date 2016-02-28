//
//  CharacterCollectionViewCell.swift
//  Wallamarvel
//
//  Created by Samuel Hervás on 25/2/16.
//  Copyright © 2016 Samuel Hervás Gómez. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell : UICollectionViewCell {
    @IBOutlet var thumbailImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    internal func setupCellForCharacter(character:Character,image:UIImage?) -> Void {
        if let thumbail = image {
            self.thumbailImage.image = thumbail
        } else {
            self.thumbailImage.image = nil
        }
        if let name = character.name {
            self.nameLabel.text = name
        }
        
        self.thumbailImage.layer.cornerRadius = self.thumbailImage.frame.width/2
        self.thumbailImage.clipsToBounds = true
    }
}