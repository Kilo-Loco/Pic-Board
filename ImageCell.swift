//
//  ImageCell.swift
//  Pic Board
//
//  Created by Kyle Lee on 4/3/16.
//  Copyright © 2016 Kilo Loco. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    var imageView: UIImageView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5.0
    }
    
//    func configureCell() -> Int{
//    
//    }
    
}
