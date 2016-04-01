//
//  KeyboardViewController.swift
//  Pic Board Keyboard
//
//  Created by Kyle Lee on 4/1/16.
//  Copyright © 2016 Kilo Loco. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var nextKeyboardButton: UIButton!
    var collection: UICollectionView!

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
    
    override func viewDidAppear(animated: Bool) {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 46, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 150, height: 50)
        
        
        self.collection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.collection.dataSource = self
        self.collection.delegate = self
        self.collection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.collection.backgroundColor = UIColor.blueColor()
        self.view.addSubview(collection)
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
        let cell = collection.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.brownColor()
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

}
