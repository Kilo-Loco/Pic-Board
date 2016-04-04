//
//  ImageCell.swift
//  Pic Board
//
//  Created by Kyle Lee on 4/3/16.
//  Copyright © 2016 Kilo Loco. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    var imageView: UIImageView?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5.0
        self.backgroundColor = UIColor.whiteColor()
        
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height))
        self.imageView?.layer.cornerRadius = 5.0
        self.imageView?.clipsToBounds = true
        self.imageView?.backgroundColor = UIColor.greenColor()
        self.imageView?.image = UIImage(named: "fry.jpg")
        self.backgroundView = self.imageView
        print("fry has been set")
        
    }
    
    func configureCell() {
        print("image will be set")
    }
    
}
