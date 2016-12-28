//
//  User.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/26/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import ObjectMapper

struct User: Mappable {
  
  var id: Int?
  var username: String?
  var firstname: String?
  var lastname: String?
  var city: String?
  var country: String?
  var usertype: String?
  var fullname: String?
  var userpicUrl: String?
  var userpicHttpsUrl: String?
  var coverUrl: String?
  var upgradeStatus: String?
  var storeOn: String?
  var affection: String?
  var avatar: Avatar?
  
  init?(map: Map) {
    mapping(map: map)
  }
  
  mutating func mapping(map: Map) {
    id <- map["id"]
    username <- map["username"]
    firstname <- map["firstname"]
    lastname <- map["lastname"]
    city <- map["city"]
    country <- map["country"]
    usertype <- map["usertype"]
    fullname <- map["fullname"]
    userpicUrl <- map["userpic_url"]
    userpicHttpsUrl <- map["userpic_https_url"]
    coverUrl <- map["cover_url"]
    upgradeStatus <- map["upgrade_status"]
    storeOn <- map["store_on"]
    affection <- map["affection"]
    if let jsonObject = map["avatars"].currentValue as? [String: Any] {
      avatar = Mapper<Avatar>().map(JSON: jsonObject)
    }
  }
  
}
