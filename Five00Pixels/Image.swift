//
//  Image.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/24/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import ObjectMapper

struct Image: Mappable {
  
  var size: Int?
  var url: String?
  var httpsUrl: String?
  var format: String?
  
  init?(map: Map) {
    mapping(map: map)
  }
  
  mutating func mapping(map: Map) {
    size <- map["size"]
    url <- map["url"]
    httpsUrl <- map["https_url"]
    format <- map["format"]
  }
  
}
