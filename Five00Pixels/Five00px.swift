//
//  API.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/24/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import PromiseKit

open class Five00px {
  
  // MARK: Get photos API
  open static func getPhotos(category: Category,
                             page: Int = 1,
                             num: Int = 20) -> Promise<GetPhotosResponse> {
    
    return Promise<GetPhotosResponse>{ fullfill, reject in
      let endpoint = API.endpoint(forPath: "photos")
      let parameters: [String: Any] = [
        "only": category.title(),
        "page": page,
        "rpp": num,
        "image_size": "3",
        "consumer_key": OAuth.default.key
      ]
      let headers = [
        "Authorization": "OAuth oauth_consumer_key=\"\(OAuth.default.key)\",oauth_consumer_secret=\"\(OAuth.default.secret)\",oauth_version=\"1.0\""
      ]
      let af = Alamofire.request(endpoint,
                                 method: .get,
                                 parameters: parameters,
                                 encoding: URLEncoding.default,
                                 headers: headers)
      af.responseObject { (response: DataResponse<GetPhotosResponse>) in
        switch response.result {
        case .failure:
          reject(response.result.error ?? noResultError())
          break
        case .success:
          guard let res = response.result.value else {
            reject(noResultError())
            return
          }
          fullfill(res)
          break
        }
      }
    }
    
  }
  
}


// MARK: - API's host, version, and endpoint configuration and resolver
fileprivate struct API {
  static var host = "https://api.500px.com"
  static var version = "v1"
  static func endpoint(forPath path: String) -> URL {
    var cleanedPath = path
    if path.characters.first == "/" {
      let index = path.index(after: path.startIndex)
      cleanedPath = path.substring(from: index)
    }
    let endpointURLString = "\(host)/\(version)/\(cleanedPath)"
    guard let url = URL(string: endpointURLString) else {
      fatalError("Endpoint: \"\(endpointURLString)\" is not valid.")
    }
    return url
  }
}

// MARK: -  Error: Shorthand and central point for create common error object
fileprivate func noResultError() -> NSError {
  let message = "Photos cannot be found."
  let info = [NSLocalizedDescriptionKey: message]
  return NSError(domain: "Five00px", code: -1, userInfo: info)
}
