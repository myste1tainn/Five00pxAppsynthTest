//
//  Category.swift
//  Five00Pixels
//
//  Created by Arnon Keereena on 12/24/16.
//  Copyright © 2016 Mysteltainn. All rights reserved.
//

import UIKit

public enum Category {
  case uncategorized
  case abstract
  case animals
  case black_and_White
  case celebrities
  case city_and_Architecture
  case commercial
  case concert
  case family
  case fashion
  case film
  case fine_Art
  case food
  case journalism
  case landscapes
  case macro
  case nature
  case nude
  case people
  case performing_Arts
  case sport
  case still_Life
  case street
  case transportation
  case travel
  case underwater
  case urban_Exploration
  case wedding
  
  static func all() -> [Category] {
    return [
      Category.uncategorized,
      Category.abstract,
      Category.animals,
      Category.black_and_White,
      Category.celebrities,
      Category.city_and_Architecture,
      Category.commercial,
      Category.concert,
      Category.family,
      Category.fashion,
      Category.film,
      Category.fine_Art,
      Category.food,
      Category.journalism,
      Category.landscapes,
      Category.macro,
      Category.nature,
      Category.nude,
      Category.people,
      Category.performing_Arts,
      Category.sport,
      Category.still_Life,
      Category.street,
      Category.transportation,
      Category.travel,
      Category.underwater,
      Category.urban_Exploration,
      Category.wedding
    ]
  }
  
  func title() -> String {
    switch self {
    case .uncategorized: return "Uncategorized"
    case .abstract: return "Abstract"
    case .animals: return "Animals"
    case .black_and_White: return "Black and White"
    case .celebrities: return "Celebrities"
    case .city_and_Architecture: return "City and Architecture"
    case .commercial: return "Commercial"
    case .concert: return "Concert"
    case .family: return "Family"
    case .fashion: return "Fashion"
    case .film: return "Film"
    case .fine_Art: return "Fine Art"
    case .food: return "Food"
    case .journalism: return "Journalism"
    case .landscapes: return "Landscapes"
    case .macro: return "Macro"
    case .nature: return "Nature"
    case .nude: return "Nude"
    case .people: return "People"
    case .performing_Arts: return "Performing Arts"
    case .sport: return "Sport"
    case .still_Life: return "Still Life"
    case .street: return "Street"
    case .transportation: return "Transportation"
    case .travel: return "Travel"
    case .underwater: return "Underwater"
    case .urban_Exploration: return "Urban Exploration"
    case .wedding: return "Wedding"
    }
  }
  
  func description() -> String {
    switch self {
    case .uncategorized: return "Uncategorized related photos"
    case .abstract: return "Abstract related photos"
    case .animals: return "Animals related photos"
    case .black_and_White: return "Black and White related photos"
    case .celebrities: return "Celebrities related photos"
    case .city_and_Architecture: return "City and Architecture related photos"
    case .commercial: return "Commercial related photos"
    case .concert: return "Concert related photos"
    case .family: return "Family related photos"
    case .fashion: return "Fashion related photos"
    case .film: return "Film related photos"
    case .fine_Art: return "Fine Art related photos"
    case .food: return "Food related photos"
    case .journalism: return "Journalism related photos"
    case .landscapes: return "Landscapes related photos"
    case .macro: return "Macro related photos"
    case .nature: return "Nature related photos"
    case .nude: return "Nude related photos"
    case .people: return "People related photos"
    case .performing_Arts: return "Performing Arts related photos"
    case .sport: return "Sport related photos"
    case .still_Life: return "Still Life related photos"
    case .street: return "Street related photos"
    case .transportation: return "Transportation related photos"
    case .travel: return "Travel related photos"
    case .underwater: return "Underwater related photos"
    case .urban_Exploration: return "Urban Exploration related photos"
    case .wedding: return "Wedding related photos"
    }
  }
  
  func image() -> UIImage? {
    var imageName = "ico-editors"
    switch self {
    case .uncategorized: imageName = "ico-popular"
    case .abstract: imageName = "ico-popular"
    case .animals: imageName = "ico-popular"
    case .black_and_White: imageName = "ico-popular"
    case .celebrities: imageName = "ico-popular"
    case .city_and_Architecture: imageName = "ico-popular"
    case .commercial: imageName = "ico-popular"
    case .concert: imageName = "ico-popular"
    case .family: imageName = "ico-popular"
    case .fashion: imageName = "ico-popular"
    case .film: imageName = "ico-popular"
    case .fine_Art: imageName = "ico-popular"
    case .food: imageName = "ico-popular"
    case .journalism: imageName = "ico-popular"
    case .landscapes: imageName = "ico-popular"
    case .macro: imageName = "ico-popular"
    case .nature: imageName = "ico-popular"
    case .nude: imageName = "ico-popular"
    case .people: imageName = "ico-popular"
    case .performing_Arts: imageName = "ico-popular"
    case .sport: imageName = "ico-popular"
    case .still_Life: imageName = "ico-popular"
    case .street: imageName = "ico-popular"
    case .transportation: imageName = "ico-popular"
    case .travel: imageName = "ico-popular"
    case .underwater: imageName = "ico-popular"
    case .urban_Exploration: imageName = "ico-popular"
    case .wedding: imageName = "ico-popular"
    }
    return UIImage(named: imageName)
  }
  
  func color() -> UIColor {
    return UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
  }
}
