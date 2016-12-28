//
//  Five00px+Response.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/26/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import ObjectMapper

extension Five00px {
  public struct GetPhotosResponse: Mappable {
    var currentPage = 1
    var totalPages = 1000
    var photos: [Photo]?
    
    public init() {}
    public init?(map: Map) {
      self.init()
      let status = map["status"].currentValue as? Int
      guard status == nil else {
        print("Unexpected JSON:\n\(map.JSON)")
        return nil
      }
      mapping(map: map)
    }
    public mutating func mapping(map: Map) {
      currentPage <- map["current_page"]
      totalPages <- map["total_pages"]
      photos <- map["photos"]
    }
  }
}
