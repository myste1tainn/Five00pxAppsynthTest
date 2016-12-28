//
//  PhotoScroller.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/24/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import UIKit

class PhotoScroller: NSObject {
  
  typealias OnSelectHandler = (IndexPath) -> Void
  typealias OnCursorMove = (IndexPath) -> Void
  
  // Number of items allowed for the scroll to hold in memory
  var currentPage = 0
  var pageLimit = 40
  var loadNextScrollDistance = 0.5
  var category: Category?
  var photos: [Photo?] = []
  var onLoad: (([Photo]) -> Void)?
  var onSelectHandler: OnSelectHandler?
  var onCursorMoveHandler: OnCursorMove?
  var collectionView: UICollectionView?
  var hasLoadedNextPage = false
  var selectedPhoto: Photo?
  let refresher = UIRefreshControl()
  
  /// Index paths for the current page
  var currentIndexPaths: [IndexPath] {
    let end = pageLimit * currentPage - 1
    let start = end - pageLimit + 1
    var indexPaths: [IndexPath] = []
    for i in start...end {
      indexPaths.append(IndexPath(item: i, section: 0))
    }
    return indexPaths
  }
  
	private static var CURRENT_PHOTO_SCROLLER: PhotoScroller?
  public static var current: PhotoScroller {
    get {
      guard let scroller = CURRENT_PHOTO_SCROLLER else {
        let new = PhotoScroller()
        CURRENT_PHOTO_SCROLLER = new
        return new
      }
      return scroller
    }
    set {
			CURRENT_PHOTO_SCROLLER = newValue
    }
  }
  
  public override init() {
    super.init()
  }
  
  public init(collectionView: UICollectionView) {
    super.init()
    PhotoScroller.current = self
    self.collectionView = collectionView
    
    collectionView.delegate = self
    collectionView.alwaysBounceVertical = true
    refresher.tintColor = UIColor.white
    refresher.addTarget(self,
                        action: #selector(reset),
                        for: .valueChanged)
    
    collectionView.addSubview(refresher)
  }
  
  public func reset() {
    photos = []
    currentPage = 0
    hasLoadedNextPage = false
    collectionView?.reloadData()
    loadNext()
  }
  
  func loadNextIfNeeded(forRowAt indexPath: IndexPath) {
    DispatchQueue.global().async {
      let distance = self.relativeDistance(forRowAt: indexPath)
      if !self.hasLoadedNextPage {
        if distance > self.loadNextScrollDistance && !self.hasPhoto(forRowAt: indexPath) {
          self.loadNext()
        }
      }
    }
  }
  
  func hasPhoto(forRowAt indexPath: IndexPath) -> Bool {
    let deltaRatio = 1 - loadNextScrollDistance
    let futureRatio = deltaRatio + 0.2
    let rowInFuture = Int( futureRatio * Double(pageLimit) ) + indexPath.row
    if rowInFuture < photos.count {
      return photos[rowInFuture] != nil
    } else {
      return false
    }
  }
  
  func loadNext() {
    hasLoadedNextPage = true
    currentPage += 1
    Five00px.getPhotos(category: category ?? .popular, page: currentPage, num: pageLimit)
    .then { response -> Void in
      self.hasLoadedNextPage = false
      self.currentPage = response.currentPage
      guard let photos = response.photos else {
        print("There are no photos")
        return
      }
      for photo in photos {
        self.photos.append(photo)
      }
      DispatchQueue.main.async {
        self.refresher.endRefreshing()
        self.collectionView?.insertItems(at: self.currentIndexPaths)
      }
    }
    .catch { error in
      print(error)
    }
  }
  
  func relativeDistance(forRowAt indexPath: IndexPath) -> Double {
    let distance = Double(indexPath.row % pageLimit) / Double(pageLimit)
    return distance
  }
  
  func onSelect(_ handler: @escaping OnSelectHandler) {
    onSelectHandler = handler
  }
 
  func select(photoAt indexPath: IndexPath) {
    selectedPhoto = photos[indexPath.row]
    onSelectHandler?(indexPath)
  }
  
  func onCursorMove(handler: @escaping OnCursorMove) {
    onCursorMoveHandler = handler
  }
  
  func moveCursor(to indexPath: IndexPath) {
    selectedPhoto = photos[indexPath.row]
    onCursorMoveHandler?(indexPath)
  }
}

extension PhotoScroller: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    select(photoAt: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      willDisplay cell: UICollectionViewCell,
                      forItemAt indexPath: IndexPath) {
    
    loadNextIfNeeded(forRowAt: indexPath)
    
  }
  
}
