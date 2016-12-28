//
//  UIView+Decoration.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/26/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
  func becomeRound() {
    clipsToBounds = true
    layer.cornerRadius = frame.size.width / 2
  }
  
  func appearBusy() {
    let view = UIView(frame: self.bounds)
    view.tag = 999
    view.alpha = 0
    view.backgroundColor = UIColor.black.withAlphaComponent(0.25)
    addSubview(view)
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    view.addSubview(activityIndicator)
    activityIndicator.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview()
    }
    
    activityIndicator.startAnimating()
    
    UIView.animate(withDuration: 0.2) {
      view.alpha = 1
    }
  }
  func appearUnbusy() {
    let busyView = viewWithTag(999)
    UIView.animate(withDuration: 0.2, animations: { 
      busyView?.alpha = 0
    }) { (completed) in
      busyView?.removeFromSuperview()
    }
  }
}
