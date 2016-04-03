//
//  APIHelper.swift
//  Pic Board
//
//  Created by Kyle Lee on 4/2/16.
//  Copyright © 2016 Kilo Loco. All rights reserved.
//

import Foundation

class APIHelper {
    func getImgURL(imgAcquired:(url: String, success: Bool) -> Void) {
        imgAcquired(url: "www.someurl.com", success: true)
    }
}