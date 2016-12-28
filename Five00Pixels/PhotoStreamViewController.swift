//
//  PhotoStreamViewController.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/24/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import UIKit

fileprivate class S {
  struct Key {
    static let cellID = "photoStreamCell"
  }
}


class PhotoStreamViewController: UIViewController, HasTakeoffView, HasLandingAreaView {
  
  var takeoffView: UIView?
  var landingAreaView: UIView?
  
  @IBOutlet var collectionView: UICollectionView!
  var photoScroller: PhotoScroller?
  var category: Category?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = category?.title()
    setupPhotoScroller()
    navigationController?.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.barTintColor = category?.color()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.navigationBar.barTintColor = Category.editors.color()
  }
  
  func setupPhotoScroller() {
    photoScroller = PhotoScroller(collectionView: collectionView)
    photoScroller?.category = category
    photoScroller?.loadNext()
    
    photoScroller?.onSelect { (indexPath) in
      self.changeTakeoffAndLandingView(to: indexPath)
      self.performSegue(withIdentifier: "showPhotoDetail", sender: self.takeoffView)
    }
    
    photoScroller?.onCursorMove { (indexPath) in
      self.changeTakeoffAndLandingView(to: indexPath)
      self.collectionView?.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
    }
  }
  
  func changeTakeoffAndLandingView(to indexPath: IndexPath) {
    guard
      let cell = self.collectionView.cellForItem(at: indexPath),
      let casted = cell as? PhotoStreamCell else {
        return
    }
    
    self.takeoffView = casted.imageView
    self.landingAreaView = self.takeoffView
  }
  
}

extension PhotoStreamViewController: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController,
                            animationControllerFor operation: UINavigationControllerOperation,
                            from fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let toValidForViewPhotoAnim = toVC is HasLandingAreaView || toVC is HasTakeoffView
    let fromValidForViewPhotoAnim = fromVC is HasLandingAreaView || fromVC is HasTakeoffView
    if toValidForViewPhotoAnim && fromValidForViewPhotoAnim {
      return ViewPhotoAnimator(operation: operation)
    } else {
      return nil
    }
  }
  
  @IBAction func unwindToStream(segue: UIStoryboardSegue) {}
}

extension PhotoStreamViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return photoScroller?.photos.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: S.Key.cellID, for: indexPath)
    let photo = photoScroller?.photos[indexPath.item]
    guard let casted = cell as? PhotoStreamCell else {
      fatalError("Cell is supposed to be photo stream cell")
    }
    casted.photo = photo
    return cell
  }
}
