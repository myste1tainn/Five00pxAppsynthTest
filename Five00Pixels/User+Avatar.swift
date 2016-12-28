//
//  User+Avatar.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/26/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import ObjectMapper

extension User {
  struct Avatar: Mappable {
    var defaultUrl: String?
    var largeUrl: String?
    var smallUrl: String?
    var tinyUrl: String?
    var bestResolutionImageUrl: String? {
      return largeUrl ?? defaultUrl ?? smallUrl ?? tinyUrl
    }
    
    init?(map: Map) {
      mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
      defaultUrl <- map["default.https"]
      largeUrl <- map["large.https"]
      smallUrl <- map["small.https"]
      tinyUrl <- map["tiny.https"]
      
      if defaultUrl == nil {
        defaultUrl <- map["default.http"]
      }
      if largeUrl == nil {
        largeUrl <- map["large.http"]
      }
      if smallUrl == nil {
        smallUrl <- map["small.http"]
      }
      if tinyUrl == nil {
        tinyUrl <- map["tiny.http"]
      }
    }
  }
}
