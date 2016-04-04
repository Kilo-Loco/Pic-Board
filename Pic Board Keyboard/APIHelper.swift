//
//  APIHelper.swift
//  Pic Board
//
//  Created by Kyle Lee on 4/2/16.
//  Copyright © 2016 Kilo Loco. All rights reserved.
//

import Foundation

class APIHelper {
    
    var urlArray = [String]()
    
    func getImgURL(imgAcquired:(urlList: [String], success: Bool) -> Void) {
        let session = NSURLSession.sharedSession()
        
        let requestURL = NSURL(string: "https://api.imgflip.com/get_memes")!
        
        session.dataTaskWithURL(requestURL) { (data, response, error) in
            guard error == nil && data != nil else {
                imgAcquired(urlList: [""], success: false)
                return
            }
            
            do {
                let imgDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! [String:AnyObject]
                
                guard let imgData = imgDictionary["data"] as? [String:Array<[String:AnyObject]>] else {
                    print("imgdata problem")
                    return
                }
                
                guard let memes = imgData["memes"] as Array<[String:AnyObject]>! else {
                    print("memes problem")
                    return
                }
                
                for meme in 0 ..< memes.count {
                    
                    guard let memeDictionay = memes[meme] as [String:AnyObject]! else {
                        print("memesDictionary problem")
                        return
                    }
                    
                    guard let imageURL = memeDictionay["url"] as? String else {
                        print("imageURL problem")
                        return
                    }
                    
                    self.urlArray.append(imageURL)
                    
                    //imgAcquired(url: imageURL, success: true)
                    
                    
                }
                
                imgAcquired(urlList: self.urlArray, success: true)
                
            } catch {
                imgAcquired(urlList: [""], success: false)
            }
            
            }.resume()
    }
}