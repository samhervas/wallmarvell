//
//  HTTPClient.swift
//  Wallamarvel
//
//  Created by Samuel Hervás on 23/2/16.
//  Copyright © 2016 Samuel Hervás Gómez. All rights reserved.
//

import Foundation
import Alamofire

let publicKey = "fb70fd8e6336a6176559bb9ab47c2da0"
let privateKey = "cb56e3717919ffd8f85a25d6457e9a837e8ef5d9"
let baseURL = "https://gateway.marvel.com/v1/public/"
let characterPath = "characters"

public class HTTPClient: NSObject {
    
    static let sharedInstance = HTTPClient()
    
    private let characterURLString = {
        return baseURL + characterPath
    }
    
    public func requestCharacters(offset: Int ,completionHandler: [Character] -> Void)
    {
        guard let characterURL = NSURL(string: characterURLString())
            else {
                completionHandler([])
                return
            }
        marvelAPIRequest(characterURL,offset: offset) { (response) -> Void in
            if let JSON = response.result.value {
                guard let json = JSON as? NSDictionary
                    else {
                        completionHandler([])
                        return;
                    }
                guard let data = json["data"] as? NSDictionary
                    else {
                        completionHandler([])
                        return;
                    }
                guard let results = data["results"] as? NSArray
                    else {
                        completionHandler([])
                        return;
                    }
                
                let characters = results.map({ Character(dictionary: $0 as! NSDictionary)})
                completionHandler(characters)
            }
        }
    }
    
    public func downloadThumbnail(url: NSURL,
        id: Int,
        completionHandler: UIImage? -> Void)->Void {
            let currentTimestamp = Int(NSDate().timeIntervalSince1970 * 1000)
            let hash =  String(format:"%ld%@%@",currentTimestamp, privateKey , publicKey).md5
            Alamofire.request(.GET, url, parameters: ["ts": currentTimestamp,"apikey":publicKey,"hash": hash]).responseData { (response) -> Void in
                if let image = UIImage(data: response.data!) {
                    completionHandler(image)
                    return
                }
                completionHandler(nil)
            }
    }
    
    private func marvelAPIRequest(url: NSURL,offset:Int,
                 completionHandler: Response<AnyObject, NSError> -> Void)
    {
        let currentTimestamp = Int(NSDate().timeIntervalSince1970 * 1000)
        let hash =  String(format:"%ld%@%@",currentTimestamp, privateKey , publicKey).md5
        Alamofire.request(.GET, url, parameters: ["offset":offset,"ts": currentTimestamp,"apikey":publicKey,"hash": hash]).responseJSON(completionHandler: completionHandler)
    }
}
