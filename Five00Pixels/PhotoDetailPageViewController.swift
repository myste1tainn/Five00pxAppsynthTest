//
//  PhotoDetailViewController.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/24/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import UIKit

class PhotoDetailPageViewController: UIViewController, HasLandingAreaView, HasTakeoffView {
  
  var landingAreaView: UIView?
  var takeoffView: UIView?
  @IBOutlet var doneButton: UIButton!
  var pageViewController: UIPageViewController?
 
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.hidesBackButton = true
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "loadPageViewController" {
      pageViewController = segue.destination as? UIPageViewController
      pageViewController?.delegate = self
      pageViewController?.dataSource = self
      
      guard let vc = photoDetailVC else {
        return
      }
      vc.photo = PhotoScroller.current.selectedPhoto
      title = vc.photo?.name
      
      let _ = vc.view
      landingAreaView = vc.photoImageView
      takeoffView = vc.photoImageView
      
      let vcs = [vc]
      pageViewController?.setViewControllers(vcs,
                                             direction: .forward,
                                             animated: false,
                                             completion: nil)
    }
  }
  
}

extension PhotoDetailPageViewController: UIPageViewControllerDelegate {
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          didFinishAnimating finished: Bool,
                          previousViewControllers: [UIViewController],
                          transitionCompleted completed: Bool) {
    
    if completed {
      guard
        let vc = pageViewController.viewControllers?.first,
        let photoVC = vc as? PhotoDetailViewController,
        let index = index(ofViewController: photoVC), index != NSNotFound else {
          return
      }
      let indexPath = IndexPath(item: index, section: 0)
      takeoffView = photoVC.photoImageView
      landingAreaView = photoVC.photoImageView
      title = photoVC.photo?.name
      PhotoScroller.current.moveCursor(to: indexPath)
    }
    
  }
  
}

extension PhotoDetailPageViewController: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard
      let index = index(ofViewController: viewController),
      index != 0 && index != NSNotFound,
      let photo = PhotoScroller.current.photos[index - 1] else {
        return nil
    }
    
    guard let vc = photoDetailVC else {
      return nil
    }
    
    vc.photo = photo
    return vc
  }
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard
      let index = index(ofViewController: viewController),
      index != PhotoScroller.current.photos.count - 1 && index != NSNotFound,
      let photo = PhotoScroller.current.photos[index + 1] else {
      return nil
    }
    
    guard let vc = photoDetailVC else {
      return nil
    }
    
    vc.photo = photo
    return vc
  }
  
  func index(ofViewController viewController: UIViewController) -> Array<Any>.Index? {
    guard
      let child = viewController as? PhotoDetailViewController,
      let photo = child.photo else {
        return nil
    }
    
    let index = PhotoScroller.current.photos.index {
      guard let vary = $0 else { return false }
      return vary === photo
    }
    
    return index
  }
  
  var photoDetailVC: PhotoDetailViewController? {
    let stb = UIStoryboard(name: "Main", bundle: nil)
    let vc = stb.instantiateViewController(withIdentifier: "PhotoDetail")
    guard let casted = vc as? PhotoDetailViewController else {
      return nil
    }
    return casted
  }
}
