//
//  Thumbnail.swift
//  Wallamarvel
//
//  Created by Samuel Hervás on 24/2/16.
//  Copyright © 2016 Samuel Hervás Gómez. All rights reserved.
//

import Foundation

public struct Thumbnail {
    let path : String
    let fileExtension : String
    init(path: String, fileExtension: String) {
        self.path = path
        self.fileExtension = fileExtension
    }
}