//
//  PhotoDetailViewController.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/25/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
  
  var photo: Photo?
  
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var authorNameLabel: UILabel!
  @IBOutlet weak var authorUserIdLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    avatarImageView.becomeRound()
    if let photo = photo {
      PhotoSetter.load(imageUrl: photo.imageUrl,
                       andSetOn: photoImageView)
      PhotoSetter.load(imageUrl: photo.user?.avatar?.bestResolutionImageUrl,
                       andSetOn: avatarImageView)
      
      authorNameLabel.text = photo.user?.fullname
      authorUserIdLabel.text = photo.user?.username
      title = photo.name
    }
  }
}

