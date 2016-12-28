//
//  ViewController.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/24/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import UIKit


class CategoryListViewController: UIViewController {

  var categories: [Category] = Category.all()
  var selectedCategory: Category = .uncategorized
  
  @IBOutlet weak var tableView: UITableView!
  lazy var cellHeight: CGFloat = {
//    let tbHeight = self.tableView.frame.size.height
//    let height = (tbHeight - 64) / CGFloat(self.categories.count)
//    return height
    return 80
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNeedsStatusBarAppearanceUpdate()
    
    let frame = CGRect(x: 0, y: 0, width: 100, height: 20)
    let imageView = UIImageView(frame: frame)
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(named: "logo")
    self.navigationItem.titleView = imageView
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showPhotoStream" {
      let vc = segue.destination as? PhotoStreamViewController
      vc?.category = selectedCategory
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

}


extension CategoryListViewController: UITableViewDelegate {
 
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    selectedCategory = categories[indexPath.row]
    return indexPath
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}

extension CategoryListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let dequeue = tableView.dequeueReusableCell(withIdentifier: CategoryCell.ID),
      let cell = dequeue as? CategoryCell else {
        fatalError("No cell with id \(CategoryCell.ID)")
    }
    let category = categories[indexPath.row]
    cell.titleLabel.text = category.title()
    //cell.descriptionLabel.text = category.description()
    //cell.categoryImageView.image = category.image()
    //cell.backgroundColor = category.color().withAlphaComponent(0.95)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellHeight
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }
}
