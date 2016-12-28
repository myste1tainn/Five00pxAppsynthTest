//
//  PhotoStreamCell.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/25/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import UIKit
import Alamofire

class PhotoStreamCell: UICollectionViewCell {
  @IBOutlet var imageView: UIImageView!
  var photo: Photo? {
    didSet {
      PhotoSetter.load(imageUrl: photo?.imageUrl, andSetOn: imageView)
    }
  }
  
  override func prepareForReuse() {
    for view in imageView.subviews {
      view.removeFromSuperview()
    }
    imageView.image = nil
  }
}
