//
//  YelpCategoryMatcher.swift
//  MoveAround
//
//  Created by Mohit Taneja on 10/28/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class YelpCategoryMatcher: NSObject {
    
    static let restuarantsCategories = ["restaurants", "afghani", "african", "senegalese", "southafrican", "newamerican", "tradamerican", "arabian", "argentine", "armenian", "asianfusion", "australian", "austrian", "bangladeshi", "bbq", "basque", "belgian", "brasseries", "brazilian", "breakfast_brunch", "british", "buffets", "burgers", "burmese", "cafes", "themedcafes", "cafeteria", "cajun", "cambodian", "caribbean", "dominican", "haitian", "puertorican", "trinidadian", "catalan", "cheesesteaks", "chickenshop", "chicken_wings", "chinese", "cantonese", "dimsum", "hainan", "shanghainese", "szechuan", "comfortfood", "creperies", "cuban", "czech", "delis", "diners", "dinnertheater", "ethiopian", "hotdogs", "filipino", "fishnchips", "fondue", "food_court", "foodstands", "french", "mauritius", "reunion", "gamemeat", "gastropubs", "german", "gluten_free", "greek", "guamanian", "halal", "hawaiian", "himalayan", "honduran", "hkcafe", "hotdog", "hotpot", "hungarian", "iberian", "indpak", "indonesian", "irish", "italian", "calabrian", "sardinian", "sicilian", "tuscan", "japanese", "conveyorsushi", "izakaya", "japacurry", "ramen", "teppanyaki", "kebab", "korean", "kosher", "laotian", "latin", "colombian", "salvadoran", "venezuelan", "raw_food", "malaysian", "mediterranean", "falafel", "mexican", "tacos", "mideastern", "egyptian", "lebanese", "modern_european", "mongolian", "moroccan", "newmexican", "nicaraguan", "noodles", "pakistani", "panasian", "persian", "peruvian", "pizza", "polish", "popuprestaurants", "portuguese", "poutineries", "russian", "salad", "sandwiches", "scandinavian", "scottish", "seafood", "singaporean", "slovakian", "soulfood", "soup", "southern", "spanish", "srilankan", "steak", "supperclubs", "sushi", "syrian", "taiwanese", "tapas", "tapasmallplates", "tex-mex", "thai", "turkish", "ukrainian", "uzbek", "vegan", "vegetarian", "vietnamese", "waffles", "wraps"]
    
    static let foodCategories = ["food", "acaibowls", "bagels", "bakeries", "beer_and_wine", "beverage_stores", "breweries", "brewpubs", "bubbletea", "butcher", "csa", "chimneycakes", "cideries", "coffee", "coffeeroasteries", "convenience", "cupcakes", "customcakes", "desserts", "distilleries", "diyfood", "donuts", "empanadas", "farmersmarket", "fooddeliveryservices", "foodtrucks", "gelato", "grocery", "honey", "icecream", "importedfood", "intlgrocery", "internetcafe", "juicebars", "kombucha", "organic_stores", "cakeshop", "piadina", "poke", "pretzels", "shavedice", "shavedsnow", "smokehouse", "gourmet", "candy", "cheese", "chocolate", "markets", "healthmarkets", "herbsandspices", "macarons", "meats", "oliveoil", "pastashops", "popcorn", "seafoodmarkets", "streetvendors", "tea", "waterstores", "wineries", "winetastingroom"]
    
    class func isCategoryRestaurant(category: String)->Bool {
        if restuarantsCategories.contains(category) || foodCategories.contains(category) {
            return true
        }
        return false
    }
    
    class func isCategoryRestaurant(categories: [String])->Bool {
        var isFoodCategoryPresent = false;
        for category in categories {
            isFoodCategoryPresent = isFoodCategoryPresent || isCategoryRestaurant(category: category)
        }
        return isFoodCategoryPresent
    }
    
    class func isCategoryRestaurant(categories: [Substring])->Bool {
        var stringCategories = [String]()
        for category in categories {
            stringCategories.append(String(category))
        }
        return isCategoryRestaurant(categories: stringCategories)
    }
}
