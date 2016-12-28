//
//  Five00PixelsTests.swift
//  Five00PixelsTests
//
//  Created by Arnon Keereena on 12/24/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import XCTest
import PromiseKit
@testable import Five00Pixels

class Five00pxTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test_getPhotos() {
    let exp = expectation(description: "Hello")
    let _ = Five00px.getPhotos(category: .popular).then { (photos) -> Void in
      print(photos)
      exp.fulfill()
    }.catch { (error) -> Void in
      exp.fulfill()
    }
  }
  
}
