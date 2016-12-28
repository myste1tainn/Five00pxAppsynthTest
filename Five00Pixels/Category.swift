//
//  Category.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/24/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import UIKit

public enum Category {
  case popular
  case upcoming
  case editors
  case fresh_today
  
  static func all() -> [Category] {
    return [
      Category.popular,
      Category.upcoming,
      Category.editors,
      Category.fresh_today
    ]
  }
  
  func title() -> String {
    switch self {
    case .popular: return "Popuplar"
    case .upcoming: return "Upcoming"
    case .editors: return "Editors"
    case .fresh_today: return "Fresh"
    }
  }
  
  func description() -> String {
    switch self {
    case .popular: return "Pixels that you'll fall in love."
    case .upcoming: return "Pixels that you'll want to see."
    case .editors: return "Pixels that we finely hand-picked."
    case .fresh_today: return "Freshly & yummy made pixels."
    }
  }
  
  func image() -> UIImage? {
    var imageName = "ico-editors"
    switch self {
    case .popular: imageName = "ico-popular"
    case .upcoming: imageName = "ico-upcoming"
    case .editors: imageName = "ico-editors"
    case .fresh_today: imageName = "ico-fresh"
    }
    return UIImage(named: imageName)
  }
  
  func color() -> UIColor {
    switch self {
    case .popular: return UIColor(red: 0.914, green: 0.239, blue: 0.682, alpha: 1)
    case .upcoming: return UIColor(red:1, green:0.569, blue:0.302, alpha:1)
    case .editors: return UIColor(red:0.2, green:0.2, blue:0.2, alpha:1)
    case .fresh_today: return UIColor(red:0, green:0.749, blue:0.753, alpha:1)
    }
  }
}
