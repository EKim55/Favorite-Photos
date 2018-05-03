//
//  PhotoViewCell.swift
//  Favorite Photos
//
//  Created by CSSE Department on 5/3/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class PhotoViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    func display(snapshot: DocumentSnapshot) {
        if let url = snapshot.get("url") as? String {
            print("Loading photo")
            ImageUtils.load(imageView: imageView, from: url)
        }
        if let caption = snapshot.get("caption") as? String {
            captionLabel.text = caption
        }
    }
}
