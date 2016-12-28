//
//  ViewPhotoSegue.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/25/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import UIKit
import SnapKit

protocol HasTakeoffView {
  var takeoffView: UIView? { get set }
}

protocol HasLandingAreaView {
  var landingAreaView: UIView? { get set }
}

class ViewPhotoAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  var operation: UINavigationControllerOperation = .push
  init(operation: UINavigationControllerOperation) {
    super.init()
    self.operation = operation
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.4
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    pushAnimate(using: transitionContext)
  }
  
  func pushAnimate(using transitionContext: UIViewControllerContextTransitioning ) {
    let containerView = transitionContext.containerView
    guard
      let source = transitionContext.viewController(forKey: .from),
      let destination = transitionContext.viewController(forKey: .to) else {
        return
    }
    
    containerView.addSubview(destination.view)
    guard
      let takeoff = source as? HasTakeoffView,
      let takeoffView = takeoff.takeoffView,
      let landing = destination as? HasLandingAreaView,
      let landingAreaView = landing.landingAreaView else {
        return
    }
    
    let originalColor = operation == .push ? destination.view.backgroundColor : UIColor.clear
    let color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    containerView.backgroundColor = operation == .push ? UIColor.clear : color
    destination.view.backgroundColor = operation == .push ? UIColor.clear : color
    
    var frame: CGRect
    var destinationFrame: CGRect
    var originalSuperview: UIView?
    if operation == .push {
      frame = takeoffView.convert(takeoffView.bounds, to: containerView)
      destinationFrame = landingAreaView.frame
      frame.origin.y -= 64
    } else {
      frame = takeoffView.convert(takeoffView.bounds, to: containerView)
      destinationFrame = landingAreaView.convert(landingAreaView.bounds, to: nil)
    }
    
    landingAreaView.frame = frame
    
    if let imageView = landingAreaView as? UIImageView {
      imageView.image = (takeoffView as? UIImageView)?.image
    } else {
      let imageView = UIImageView(frame: landingAreaView.bounds)
      landingAreaView.addSubview(imageView)
      
      let masks: UIViewAutoresizing = [.flexibleTopMargin,
                                       .flexibleBottomMargin,
                                       .flexibleLeftMargin,
                                       .flexibleRightMargin,
                                       .flexibleWidth,
                                       .flexibleHeight]
      imageView.autoresizingMask = masks
      imageView.contentMode = .scaleAspectFit
      imageView.image = (takeoffView as? UIImageView)?.image
    }
    
    if operation == .pop {
      originalSuperview = landingAreaView.superview
      containerView.addSubview(landingAreaView)
      landingAreaView.snp.makeConstraints({ (make) in
        make.top.equalTo(destinationFrame.origin.y)
        make.left.equalTo(destinationFrame.origin.x)
        make.width.equalTo(destinationFrame.size.width)
        make.height.equalTo(destinationFrame.size.height)
      })
    }
    
    
    let animationBlock = {
      containerView.backgroundColor = originalColor
      destination.view.backgroundColor = originalColor
      landingAreaView.frame = destinationFrame
    }
    
    let completionBlock = { (completed: Bool) in
      let cancelled = transitionContext.transitionWasCancelled
      transitionContext.completeTransition(!cancelled)
      if self.operation == .pop && !cancelled {
        guard let bounds = originalSuperview?.bounds else {
          return
        }
        landingAreaView.frame = bounds
        originalSuperview?.addSubview(landingAreaView)
        landingAreaView.snp.makeConstraints({ (make) in
          make.edges.equalToSuperview()
        })
      }
    }
    
    let duration = transitionDuration(using: transitionContext)
    
    if operation == .pop {
      UIView.animate(withDuration: duration / 2,
                     delay: 0,
                     options: .curveEaseOut,
                     animations: animationBlock,
                     completion: completionBlock)
    } else {
      UIView.animate(withDuration: duration,
                     delay: 0,
                     usingSpringWithDamping: 0.9,
                     initialSpringVelocity: 0.0,
                     options: .curveEaseOut,
                     animations: animationBlock,
                     completion: completionBlock)
    }
  }
}
