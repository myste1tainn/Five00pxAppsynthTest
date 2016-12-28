//
//  PhotoStreamFlowLayout.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/25/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import UIKit

class PhotoStreamFlowLayout: UICollectionViewFlowLayout {
  
  lazy var halfScreenWidth: CGFloat = {
    let hw = UIScreen.main.bounds.size.width / 2
    return hw
  }()
  
  lazy var halfScreenItemSize: CGSize = {
//    let w = self.halfScreenWidth - (self.halfScreenWidth * 0.01)
    let w = self.halfScreenWidth
    let size = CGSize(width: w, height: w)
    return size
  }()
  
  override var itemSize: CGSize {
    get {
      return self.halfScreenItemSize
    }
    set {
      return
    }
  }
  
  override var minimumInteritemSpacing: CGFloat {
    get {
//      return halfScreenWidth * 0.01
      return 0
    }
    set {
      return
    }
  }
  
  override var minimumLineSpacing: CGFloat {
    get {
//      return halfScreenWidth * 0.01
      return 0
    }
    set {
      return
    }
  }
  
}
