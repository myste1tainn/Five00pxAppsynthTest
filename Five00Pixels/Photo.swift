//
//  Photo.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/24/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import Foundation
import ObjectMapper

class Photo: Mappable {
  var id: String?
  var userId: String?
  var name: String?
  var description: String?
  var camera: String?
  var lens: String?
  var focalLength: String?
  var iso: String?
  var shutterSpeed: String?
  var aperture: String?
  var timesViewed: String?
  var rating: String?
  var status: String?
  var createdAt: String?
  var category: String?
  var location: String?
  var latitude: String?
  var longitude: String?
  var takenAt: String?
  var hiResUploaded: String?
  var forSale: String?
  var width: String?
  var height: String?
  var votesCount: String?
  var favoritesCount: String?
  var commentsCount: String?
  var nsfw: String?
  var salesCount: String?
  var forSaleDate: String?
  var highestRating: String?
  var highestRatingDate: String?
  var licenseType: String?
  var converted: String?
  var collectionsCount: String?
  var cropVersion: String?
  var privacy: String?
  var profile: String?
  var imageUrl: String?
  var images: [Image]?
  var url: String?
  var positiveVotesCount: String?
  var convertedBits: String?
  var storeDownload: String?
  var storePrint: String?
  var storeLicense: String?
  var requestToBuyEnabled: String?
  var licenseRequestsEnabled: String?
  var storeWidth: String?
  var storeHeight: String?
  var voted: String?
  var liked: String?
  var disliked: String?
  var purchased: String?
  var watermark: String?
  var imageFormat: String?
  var user: User?
  
  init() {}
  public required init?(map: Map) {
    mapping(map: map)
  }
  
  func mapping(map: Map) {
    id <- map["id"]
    userId <- map["user_id"]
    name <- map["name"]
    description <- map["description"]
    camera <- map["camera"]
    lens <- map["lens"]
    focalLength <- map["focal_length"]
    iso <- map["iso"]
    shutterSpeed <- map["shutter_speed"]
    aperture <- map["aperture"]
    timesViewed <- map["times_viewed"]
    rating <- map["rating"]
    status <- map["status"]
    createdAt <- map["created_at"]
    category <- map["category"]
    location <- map["location"]
    latitude <- map["latitude"]
    longitude <- map["longitude"]
    takenAt <- map["taken_at"]
    hiResUploaded <- map["hi_res_uploaded"]
    forSale <- map["for_sale"]
    width <- map["width"]
    height <- map["height"]
    votesCount <- map["votes_count"]
    favoritesCount <- map["favorites_count"]
    commentsCount <- map["comments_count"]
    nsfw <- map["nsfw"]
    salesCount <- map["sales_count"]
    forSaleDate <- map["for_sale_date"]
    highestRating <- map["highest_rating"]
    highestRatingDate <- map["highest_rating_date"]
    licenseType <- map["license_type"]
    converted <- map["converted"]
    collectionsCount <- map["collections_count"]
    cropVersion <- map["crop_version"]
    privacy <- map["privacy"]
    profile <- map["profile"]
    imageUrl <- map["image_url"]
    if let jsonArray = map["images"].currentValue as? [[String: Any]] {
      images = Mapper<Image>().mapArray(JSONArray: jsonArray)
    }
    url <- map["url"]
    positiveVotesCount <- map["positive_votes_count"]
    convertedBits <- map["converted_bits"]
    storeDownload <- map["store_download"]
    storePrint <- map["store_print"]
    storeLicense <- map["store_license"]
    requestToBuyEnabled <- map["request_to_buy_enabled"]
    licenseRequestsEnabled <- map["license_requests_enabled"]
    storeWidth <- map["store_width"]
    storeHeight <- map["store_height"]
    voted <- map["voted"]
    liked <- map["liked"]
    disliked <- map["disliked"]
    purchased <- map["purchased"]
    watermark <- map["watermark"]
    imageFormat <- map["image_format"]
    if let jsonObject = map["user"].currentValue as? [String: Any] {
      user = Mapper<User>().map(JSON: jsonObject)
    }
  }
  
}
