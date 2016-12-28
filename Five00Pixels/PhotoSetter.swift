//
//  PhotoSetter.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/26/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import UIKit
import Alamofire

class PhotoSetter {
  
  // OPTIMIZATION: This could use some local caching for better performance
  static func load(imageUrl: String?, andSetOn imageView: UIImageView) {
    imageView.image = nil
    imageView.appearBusy()
    guard
      let urlString = imageUrl,
      let url = URL(string: urlString) else {
        imageView.image = UIImage(named: "bg-no-photo")
        imageView.appearUnbusy()
        return
    }
    request(url).responseData(completionHandler: { (response) in
      guard let data = response.result.value else {
        imageView.image = UIImage(named: "bg-no-photo")
        imageView.appearUnbusy()
        return
      }
      imageView.appearUnbusy()
      imageView.image = UIImage(data: data)
    })
  }
  
}
