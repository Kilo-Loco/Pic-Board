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
    
    var imageArray = [UIImage]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5.0
        self.backgroundColor = UIColor.whiteColor()
        
//        self.imageArray = [
//            UIImage(named: "amc.jpg")!, UIImage(named: "mcdonalds.jpg")!, UIImage(named: "puppy.jpg")!
//        ]
        
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height))
        self.imageView?.layer.cornerRadius = 5.0
        self.imageView?.clipsToBounds = true
        self.imageView?.backgroundColor = UIColor.greenColor()
        self.imageView?.image = UIImage(named: "fry.jpg")
        self.backgroundView = self.imageView
        
    }
    
    func configureCell(array: [UIImage], counter: Int) {
        
        print(counter)
        self.imageView?.image = array[counter]
    }
    
}
