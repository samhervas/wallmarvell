//
//  Character.swift
//  Wallamarvel
//
//  Created by Samuel Hervás on 24/2/16.
//  Copyright © 2016 Samuel Hervás Gómez. All rights reserved.
//

import Foundation

public struct Character {
    let id : Int!
    let name : String!
    let description : String!
    let thumbnail : Thumbnail!
    
    init (dictionary:NSDictionary) {
        id = dictionary["id"] as! Int
        name = dictionary["name"] as! String!
        description = dictionary["description"] as! String!
        thumbnail = Thumbnail(path:dictionary["thumbnail"]!["path"] as! String, fileExtension:dictionary["thumbnail"]!["extension"] as! String)
    }
}