//
//  KeyboardViewController.swift
//  Pic Board Keyboard
//
//  Created by Kyle Lee on 4/1/16.
//  Copyright © 2016 Kilo Loco. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    var collection: UICollectionView!
    var searchBar: UISearchBar!
    var segmentedControl: UISegmentedControl!
    var imageArray = [String]()
    var displayedImage: UIImage!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .System)
        
        
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor).active = true
        self.nextKeyboardButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        let apiHelper = APIHelper()
        apiHelper.getImgURL { (urlList, success) in
            guard success else {
                dispatch_async(dispatch_get_main_queue(), {
                    print("WE HAVE A PROBLEM")
                })
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.imageArray = urlList
                for i in 0 ..< self.imageArray.count {
                    let url = NSURL(string: self.imageArray[i])
                    
                    let data = NSData(contentsOfURL: url!)
                    
                    self.displayedImage = UIImage(data: data!)
                    print(self.imageArray[i])
                    
                    
                }
                self.collection.reloadData()
            })
            
        }

        
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.view.backgroundColor = UIColor.darkTextColor()
//        
//        let apiHelper = APIHelper()
//        apiHelper.getImgURL { (urlList, success) in
//            guard success else {
//                dispatch_async(dispatch_get_main_queue(), {
//                    print("WE HAVE A PROBLEM")
//                })
//                return
//            }
//            
//            dispatch_async(dispatch_get_main_queue(), {
//                self.imageArray = urlList
//                print(self.imageArray)
//                print(self.imageArray.count)
//                for i in 0 ..< self.imageArray.count {
//                    let url = NSURL(string: self.imageArray[i])
//                    
//                    let data = NSData(contentsOfURL: url!)
//                    
//                    self.displayedImage = UIImage(data: data!)
//                }
//            })
//            
//        }
        
        
        
        
        
        
        
        // Search Bar UI Setup
        self.searchBar = UISearchBar(frame: CGRectMake(0, 8, (self.view.frame.width - 8), 30))
        self.searchBar.delegate = self
        self.view.addSubview(self.searchBar)
        
        // Collection View Flow Layout UI Setup
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        
        // Collection View UI Setup
        
        self.collection = UICollectionView(frame: CGRectMake(0, 45, self.view.frame.width, 136), collectionViewLayout: layout)
        layout.itemSize = CGSize(width: 150, height: (self.collection.frame.height/2)-1)
        self.collection.dataSource = self
        self.collection.delegate = self
        self.collection.registerClass(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        self.collection.backgroundColor = UIColor.blackColor()
        self.collection.showsHorizontalScrollIndicator = false
        self.view.addSubview(collection)
        self.view.sendSubviewToBack(self.collection)
        
        //Segmented Control UI Setup
        let segControlHeight = self.view.frame.maxY - self.collection.frame.maxY
        let segControlWidth = self.view.frame.maxX - self.nextKeyboardButton.frame.maxX
        self.segmentedControl = UISegmentedControl(frame: CGRectMake(self.nextKeyboardButton.frame.maxX, self.collection.frame.maxY, segControlWidth, segControlHeight))
        let tabs = ["Favs", "Local", "Trending"]
        for index in 0 ..< tabs.count {
            let tab = tabs[index]
            self.segmentedControl.insertSegmentWithTitle(tab, atIndex: index, animated: true)
        }
        self.segmentedControl.tintColor = UIColor.whiteColor()
        self.view.addSubview(self.segmentedControl)
        
        self.nextKeyboardButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }
    
    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.blackColor()
        
        
        let anImage = UIImageView.init(frame: CGRectMake(0, 0, cell.frame.width, cell.frame.height))
        anImage.layer.cornerRadius = 5.0
        anImage.clipsToBounds = true
        anImage.image = self.displayedImage
        cell.addSubview(anImage)
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    //    func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    //        <#code#>
    //    }
}
