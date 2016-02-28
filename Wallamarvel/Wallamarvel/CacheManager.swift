//
//  CacheManager.swift
//  Wallamarvel
//
//  Created by Samuel Hervás on 25/2/16.
//  Copyright © 2016 Samuel Hervás Gómez. All rights reserved.
//

import Foundation

public class CacheManger {
    static let sharedInstance = CacheManger()
    public let imageCache = NSCache()
    
}