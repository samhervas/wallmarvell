//
//  File.swift
//  Wallamarvel
//
//  Created by Samuel Hervás on 25/2/16.
//  Copyright © 2016 Samuel Hervás Gómez. All rights reserved.
//

import UIKit

let tintColor = UIColor(
    red:19.0/255.0,
    green:195.0/255.0,
    blue:172.00/255.0,
    alpha:1.0)

class WallaMarvelTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        let item = self.tabBar.items![0]
        tabBar.tintColor = tintColor
        item.selectedImage = item.image!.imageWithRenderingMode(.AlwaysTemplate)
    }
    
}
