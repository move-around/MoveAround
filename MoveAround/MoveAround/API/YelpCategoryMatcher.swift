//
//  YelpCategoryMatcher.swift
//  MoveAround
//
//  Created by Mohit Taneja on 10/28/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class YelpCategoryMatcher: NSObject {
    
    static let categoriesMapping = ["restaurant": restaurantCategories,
                                    "food": foodCategories,
                                    "active": activeLifeCategories,
                                    "arts": artsEntertainmentCategories,
                                    "automotive": automotiveCategories,
                                    "beautySpa": beautySpaCategories,
                                    "cycling": bicycleCategory,
                                    "education": educationCategory,
                                    "eventPlanning": eventPlanningCategory,
                                    "financialServices": financialServicesCategory,
                                    "healthService": healthServicesCategories,
                                    "homeService": homeServicesCategories,
                                    "localFlavor": localFlavorsCategories,
                                    "nightlife": nightlifeCategories,
                                    "landmarks": landmarkCategories,
                                    "shopping": shoppingCategories,
                                    "chineseFood": chineseRestaurantCategories,
                                    "italianFood": italianRestaurantCategories,
                                    "japaneseFood": japaneseRestaurantCategories,
                                    "mexicanFood": mexicanFoodRestaurantCategories,
                                    "mediterraneanFood": mediterraneanFoodCategories,
                                    "breakfast": breakfastRestaurantCategories,
                                    "parks": parksCategories]

    // Select only one place to be visited for a particular placeItinerary
    // based on preferences array for categories for places
    class func placeToVisitBasedOnPreferences(preferences: [String], dayItinerary: DayItinerary)->Place? {
        var selectedPlace: Place? = nil

        var preferenceList: [String] = [String]()
        for initialPreference in preferences {
            // Get the list of categories corresponding to preference
            let categoryList = categoriesMapping[initialPreference] ?? [initialPreference]
            preferenceList.append(contentsOf: categoryList)
        }
        
        // Find a place in order of preference which would be a good match for this time slot
        for preference in preferenceList {
            // Go through each place in the potential places to visit
            for place in dayItinerary.potentialPlacesToVisit {
                let categoriesForPlace = place.internalCategories!.split(separator: ",")
                if categoriesForPlace.contains(preference.split(separator: ",")[0]) {
                    selectedPlace = place
                    dayItinerary.potentialPlacesToVisit.remove(at: dayItinerary.potentialPlacesToVisit.index(of: selectedPlace!)!)
                    return selectedPlace
                }
            }
        }
        
        // If we are reaching here, this means that we weren't able to find any suitable place for this time slot
        return selectedPlace
    }

    class func isCategoryRestaurant(category: String)->Bool {
        if restaurantCategories.contains(category) || foodCategories.contains(category) {
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

    static let breakfastRestaurantCategories = ["breakfast_brunch", "sandwiches", "cafes", "themedcafes", "creperies", "coffee", "bakeries"]
    
    static let mediterraneanFoodCategories = ["mediterranean", "falafel"]
    
    static let chineseRestaurantCategories = ["chinese", "cantonese", "congee", "dimsum", "fuzhou", "hainan", "hakka", "henghwa", "hokkien", "hunan", "pekinese", "shanghainese", "szechuan", "teochew"]
    
    static let italianRestaurantCategories = ["italian", "abruzzese", "altoatesine", "apulian", "calabrian", "cucinacampana", "emilian", "friulan", "ligurian", "lumbard", "napoletana", "piemonte", "roman", "sardinian", "sicilian", "tuscan", "venetian"]
    
    static let japaneseRestaurantCategories = ["japanese", "blowfish", "conveyorsushi", "donburi", "gyudon", "oyakodon", "handrolls", "horumon", "izakaya", "japacurry", "kaiseki", "kushikatsu", "oden", "okinawan", "okonomiyaki", "onigiri", "ramen", "robatayaki", "soba", "sukiyaki", "takoyaki", "tempura", "teppanyaki", "tonkatsu", "udon", "unagi", "westernjapanese", "yakiniku", "yakitori"]
    
    static let mexicanFoodRestaurantCategories = ["mexican", "easternmexican", "jaliscan", "northernmexican", "oaxacan", "pueblan", "tacos", "tamales", "yucatan"]
    
    static let restaurantCategories = ["restaurants", "afghani", "african", "senegalese", "southafrican", "newamerican", "tradamerican", "andalusian", "arabian", "arabpizza", "argentine", "armenian", "asianfusion", "asturian", "australian", "austrian", "baguettes", "bangladeshi", "bbq", "basque", "bavarian", "beergarden", "beerhall", "beisl", "belgian", "flemish", "bistros", "blacksea", "brasseries", "brazilian", "brazilianempanadas", "centralbrazilian", "northeasternbrazilian", "northernbrazilian", "rodizios", "breakfast_brunch", "british", "buffets", "bulgarian", "burgers", "burmese", "cafes", "themedcafes", "cafeteria", "cajun", "cambodian", "newcanadian", "canteen", "caribbean", "dominican", "haitian", "puertorican", "trinidadian", "catalan", "cheesesteaks", "chickenshop", "chicken_wings", "chilean", "chinese", "cantonese", "congee", "dimsum", "fuzhou", "hainan", "hakka", "henghwa", "hokkien", "hunan", "pekinese", "shanghainese", "szechuan", "teochew", "comfortfood", "corsican", "creperies", "cuban", "currysausage", "cypriot", "czech", "czechslovakian", "danish", "delis", "diners", "dinnertheater", "dumplings", "eastern_european", "ethiopian", "hotdogs", "filipino", "fischbroetchen", "fishnchips", "flatbread", "fondue", "food_court", "foodstands", "freiduria", "french", "alsatian", "auvergnat", "berrichon", "bourguignon", "mauritius", "nicois", "provencal", "reunion", "sud_ouest", "galician", "gamemeat", "gastropubs", "georgian", "german", "baden", "easterngerman", "franconian", "hessian", "northerngerman", "palatine", "rhinelandian", "giblets", "gluten_free", "greek", "guamanian", "halal", "hawaiian", "heuriger", "himalayan", "honduran", "hkcafe", "hotdog", "hotpot", "hungarian", "iberian", "indpak", "indonesian", "international", "irish", "island_pub", "israeli", "italian", "abruzzese", "altoatesine", "apulian", "calabrian", "cucinacampana", "emilian", "friulan", "ligurian", "lumbard", "napoletana", "piemonte", "roman", "sardinian", "sicilian", "tuscan", "venetian", "japanese", "blowfish", "conveyorsushi", "donburi", "gyudon", "oyakodon", "handrolls", "horumon", "izakaya", "japacurry", "kaiseki", "kushikatsu", "oden", "okinawan", "okonomiyaki", "onigiri", "ramen", "robatayaki", "soba", "sukiyaki", "takoyaki", "tempura", "teppanyaki", "tonkatsu", "udon", "unagi", "westernjapanese", "yakiniku", "yakitori", "jewish", "kebab", "kopitiam", "korean", "kosher", "kurdish", "laos", "laotian", "latin", "colombian", "salvadoran", "venezuelan", "raw_food", "lyonnais", "malaysian", "mamak", "nyonya", "meatballs", "mediterranean", "falafel", "mexican", "easternmexican", "jaliscan", "northernmexican", "oaxacan", "pueblan", "tacos", "tamales", "yucatan", "mideastern", "egyptian", "lebanese", "milkbars", "modern_australian", "modern_european", "mongolian", "moroccan", "newmexican", "newzealand", "nicaraguan", "nightfood", "nikkei", "noodles", "norcinerie", "opensandwiches", "oriental", "pfcomercial", "pakistani", "panasian", "eltern_cafes", "parma", "persian", "peruvian", "pita", "pizza", "polish", "pierogis", "popuprestaurants", "portuguese", "alentejo", "algarve", "azores", "beira", "fado_houses", "madeira", "minho", "ribatejo", "tras_os_montes", "potatoes", "poutineries", "pubfood", "riceshop", "romanian", "rotisserie_chicken", "russian", "salad", "sandwiches", "scandinavian", "schnitzel", "scottish", "seafood", "serbocroatian", "signature_cuisine", "singaporean", "slovakian", "soulfood", "soup", "southern", "spanish", "arroceria_paella", "srilankan", "steak", "supperclubs", "sushi", "swabian", "swedish", "swissfood", "syrian", "tabernas", "taiwanese", "tapas", "tapasmallplates", "tavolacalda", "tex-mex", "thai", "norwegian", "traditional_swedish", "trattorie", "turkish", "cheekufta", "gozleme", "homemadefood", "lahmacun", "ottomancuisine", "turkishravioli", "ukrainian", "uzbek", "vegan", "vegetarian", "venison", "vietnamese", "waffles", "wok", "wraps", "yugoslav"]
    
    static let foodCategories = ["food", "acaibowls", "backshop", "bagels", "bakeries", "beer_and_wine", "bento", "beverage_stores", "breweries", "brewpubs", "bubbletea", "butcher", "csa", "chimneycakes", "churros", "cideries", "coffee", "coffeeteasupplies", "coffeeroasteries", "convenience", "cupcakes", "customcakes", "delicatessen", "desserts", "distilleries", "diyfood", "donairs", "donuts", "empanadas", "ethicgrocery", "farmersmarket", "fishmonger", "fooddeliveryservices", "foodtrucks", "friterie", "gelato", "grocery", "hawkercentre", "honey", "icecream", "importedfood", "intlgrocery", "internetcafe", "jpsweets", "taiyaki", "juicebars", "kiosk", "kombucha", "milkshakebars", "gluhwein", "nasilemak", "organic_stores", "panzerotti", "eltern_cafes", "cakeshop", "piadina", "poke", "pretzels", "salumerie", "shavedice", "shavedsnow", "smokehouse", "gourmet", "candy", "cheese", "chocolate", "dagashi", "driedfruit", "frozenfood", "markets", "healthmarkets", "herbsandspices", "macarons", "meats", "oliveoil", "pastashops", "popcorn", "seafoodmarkets", "tofu", "streetvendors", "sugarshacks", "tea", "torshi", "tortillas", "waterstores", "wineries", "winetastingroom", "zapiekanka"]
    
    static let activeLifeCategories = ["active", "atvrentals", "airsoft", "amateursportsteams", "amusementparks", "aquariums", "archery", "badminton", "baseballfields", "basketballcourts", "bathing_area", "battingcages", "beachequipmentrental", "beachvolleyball", "beaches", "bicyclepaths", "bikeparking", "bikerentals", "boating", "bobsledding", "bocceball", "bowling", "bubblesoccer", "bungeejumping", "carousels", "challengecourses", "climbing", "cyclingclasses", "daycamps", "discgolf", "diving", "freediving", "scuba", "escapegames", "experiences", "fencing", "fishing", "fitness", "aerialfitness", "barreclasses", "bootcamps", "boxing", "cardioclasses", "dancestudio", "emstraining", "golflessons", "gyms", "circuittraininggyms", "intervaltraininggyms", "martialarts", "brazilianjiujitsu", "chinesemartialarts", "karate", "kickboxing", "muaythai", "taekwondo", "meditationcenters", "pilates", "qigong", "selfdefenseclasses", "swimminglessons", "taichi", "healthtrainers", "yoga", "flyboarding", "gliding", "gokarts", "golf", "gun_ranges", "gymnastics", "handball", "hanggliding", "hiking", "horseracing", "horsebackriding", "hot_air_balloons", "indoor_playcenter", "jetskis", "kids_activities", "kiteboarding", "lakes", "lasertag", "lawn_bowling", "mini_golf", "mountainbiking", "nudist", "paddleboarding", "paintball", "parasailing", "parks", "dog_parks", "skate_parks", "playgrounds", "publicplazas", "races", "racingexperience", "rafting", "recreation", "rock_climbing", "sailing", "scavengerhunts", "scooterrentals", "seniorcenters", "skatingrinks", "skiing", "skydiving", "sledding", "snorkeling", "football", "sport_equipment_hire", "sports_clubs", "squash", "summer_camps", "surflifesaving", "surfing", "swimmingpools", "tennis", "trampoline", "tubing", "volleyball", "waterparks", "wildlifehunting", "zipline", "zoos", "pettingzoos", "zorbing"]

    static let artsEntertainmentCategories = ["arts", "arcades", "galleries", "bettingcenters", "bingo", "gardens", "cabaret", "casinos", "castles", "choirs", "movietheaters", "driveintheater", "outdoormovies", "countryclubs", "culturalcenter", "eatertainment", "farms", "attractionfarms", "pickyourown", "ranches", "festivals", "xmasmarkets", "funfair", "generalfestivals", "tradefairs", "hauntedhouses", "jazzandblues", "lancenters", "mahjong", "makerspaces", "marchingbands", "museums", "artmuseums", "childrensmuseums", "musicvenues", "observatories", "opera", "pachinko", "paintandsip", "theater", "planetarium", "sportsteams", "racetracks", "rodeo", "social_clubs", "veteransorganizations", "stadiumsarenas", "streetart", "studiotaping", "psychic_astrology", "astrologers", "mystics", "psychicmediums", "psychics", "tablaoflamenco", "ticketsales", "virtualrealitycenters", "wineries", "winetastingroom"]
    
    static let automotiveCategories = ["auto", "aircraftdealers", "aircraftrepairs", "autocustomization", "auto_detailing", "autoelectric", "autoglass", "carwindowtinting", "autoloanproviders", "autopartssupplies", "autorepair", "diyautoshop", "autosecurity", "autoupholstery", "boatdealers", "bodyshops", "carauctions", "carbrokers", "carbuyers", "car_dealers", "autodamageassessment", "carshares", "stereo_installation", "carwash", "truckdealers", "truckrepair", "evchargingstations", "fueldocks", "servicestations", "golfcartdealers", "hybridcarrepair", "interlocksystems", "marinas", "mobiledentrepair", "mobilityequipment", "motorcycledealers", "motorcyclerepair", "motodealers", "motorepairs", "oilchange", "parking", "rv_dealers", "rvrepair", "registrationservices", "roadsideassist", "service_stations", "smog_check_stations", "tires", "towing", "trailerdealers", "trailerrental", "trailerrepair", "transmissionrepair", "truck_rental", "usedcardealers", "vehicleshipping", "vehiclewraps", "wheelrimrepair", "windshieldinstallrepair"]
    
    static let beautySpaCategories = ["beautysvc", "acnetreatment", "barbers", "cosmetics", "spas", "eroticmassage", "eyebrowservices", "eyelashservice", "hair_extensions", "hairloss", "hairremoval", "laser_hair_removal", "sugaring", "threadingservices", "waxing", "hair", "blowoutservices", "hair_extensions", "hairstylists", "menshair", "hotsprings", "makeupartists", "massage", "medicalspa", "othersalons", "nailtechnicians", "perfume", "permanentmakeup", "piercing", "skincare", "tanning", "spraytanning", "tanningbeds", "tattoo", "teethwhitening"]
    
    static let bicycleCategory = ["bicycles", "bikeassociations", "bikerepair", "bikeshop", "specialbikes"]
    
    static let educationCategory = ["education", "adultedu", "artclasses", "glassblowing", "collegecounseling", "collegeuniv", "educationservices", "elementaryschools", "highschools", "montessori", "preschools", "privateschools", "privatetutors", "religiousschools", "specialed", "specialtyschools", "artschools", "bartendingschools", "cprclasses", "cheerleading", "childbirthedu", "circusschools", "cookingschools", "cosmetology_schools", "duischools", "dance_schools", "dramaschools", "driving_schools", "firearmtraining", "firstaidclasses", "flightinstruction", "foodsafety", "language_schools", "massage_schools", "nursingschools", "parentingclasses", "photoclasses", "poledancingclasses", "sambaschools", "skischools", "speechtraining", "surfschools", "swimminglessons", "trafficschools", "vocation", "tastingclasses", "cheesetastingclasses", "winetasteclasses", "testprep", "tutoring", "waldorfschools"]
    
    static let eventPlanningCategory = ["eventservices", "balloonservices", "bartenders", "boatcharters", "stationery", "caricatures", "catering", "clowns", "djs", "facepainting", "floraldesigners", "gametruckrental", "golfcartrentals", "hennaartists", "hotels", "agriturismi", "mountainhuts", "pensions", "residences", "reststops", "ryokan", "magicians", "mohels", "musicians", "officiants", "eventplanning", "partybikerentals", "partybusrentals", "partycharacters", "partyequipmentrentals", "audiovisualequipmentrental", "bouncehouserentals", "partysupplies", "personalchefs", "photoboothrentals", "photographers", "boudoirphotography", "eventphotography", "sessionphotography", "silentdisco", "sommelierservices", "teambuilding", "triviahosts", "valetservices", "venues", "videographers", "weddingchappels", "wedding_planning"]
 
    static let financialServicesCategory = ["financialservices", "banks", "businessfinancing", "paydayloans", "currencyexchange", "debtrelief", "financialadvising", "installmentloans", "insurance", "autoinsurance", "homeinsurance", "lifeinsurance", "investing", "mortgagelenders", "taxservices", "titleloans"]
    
    static let healthServicesCategories = ["health", "acupuncture", "alternativemedicine", "animalassistedtherapy", "assistedliving", "ayurveda", "behavioranalysts", "blooddonation", "bodycontouring", "cannabis_clinics", "cannabistours", "cannabiscollective", "chiropractors", "colonics", "conciergemedicine", "c_and_mh", "psychoanalysts", "psychologists", "psychotherapists", "sextherapists", "sophrologists", "sportspsychologists", "cryotherapy", "dentalhygienists", "dentalhygienistsmobile", "dentalhygeiniststorefront", "dentists", "cosmeticdentists", "endodontists", "generaldentistry", "oralsurgeons", "orthodontists", "pediatric_dentists", "periodontists", "diagnosticservices", "diagnosticimaging", "laboratorytesting", "dialysisclinics", "dietitians", "physicians", "addictionmedicine", "allergist", "anesthesiologists", "audiologist", "cardiology", "cosmeticsurgeons", "dermatology", "earnosethroat", "emergencymedicine", "endocrinologists", "familydr", "fertility", "gastroenterologist", "geneticists", "gerontologist", "hepatologists", "homeopathic", "hospitalists", "immunodermatologists", "infectiousdisease", "internalmed", "naturopathic", "nephrologists", "neurologist", "neuropathologists", "neurotologists", "obgyn", "oncologist", "opthamalogists", "retinaspecialists", "orthopedists", "osteopathicphysicians", "otologists", "painmanagement", "pathologists", "pediatricians", "phlebologists", "plasticsurgeons", "podiatrists", "preventivemedicine", "proctologist", "psychiatrists", "pulmonologist", "radiologists", "rhematologists", "spinesurgeons", "sportsmed", "surgeons", "tattooremoval", "toxicologists", "tropicalmedicine", "underseamedicine", "urologists", "vascularmedicine", "doulas", "emergencyrooms", "floatspa", "habilitativeservices", "halfwayhouses", "halotherapy", "healthcoach", "healthinsurance", "hearingaidproviders", "hearing_aids", "herbalshops", "homehealthcare", "hospice", "hospitals", "hydrotherapy", "hypnosis", "ivhydration", "lactationservices", "laserlasikeyes", "liceservices", "massage_therapy", "cannabisreferrals", "medcenters", "bulkbilling", "osteopaths", "walkinclinics", "medicalfoot", "medicalspa", "medicaltransportation", "midwives", "nursepractitioner", "nutritionists", "occupationaltherapy", "optometrists", "organdonorservices", "orthotics", "oxygenbars", "personalcare", "pharmacy", "physicaltherapy", "placentaencapsulation", "prenatal", "prosthetics", "prosthodontists", "psychotechnicaltests", "reflexology", "rehabilitation_center", "reiki", "retirement_homes", "saunas", "skillednursing", "sleepspecialists", "speech_therapists", "spermclinic", "tcm", "tuina", "urgent_care", "weightlosscenters"]
    
    static let homeServicesCategories = ["homeservices", "artificialturf", "buildingsupplies", "cabinetry", "carpenters", "carpetinstallation", "carpeting", "childproofing", "chimneysweeps", "contractors", "countertopinstall", "damagerestoration", "decksrailing", "demolitionservices", "doorsales", "drywall", "electricians", "excavationservices", "fencesgates", "fireprotection", "fireplace", "firewood", "flooring", "foundationrepair", "furnitureassembly", "garage_door_services", "gardeners", "glassandmirrors", "groutservices", "gutterservices", "handyman", "hvac", "seasonaldecorservices", "homeautomation", "homecleaning", "homeenergyauditors", "home_inspectors", "homenetworkinstall", "home_organization", "hometheatreinstallation", "homewindowtinting", "housesitters", "insulationinstallation", "interiordesign", "isps", "irrigation", "locksmiths", "landscapearchitects", "landscaping", "lawnservices", "lighting", "masonry_concrete", "mobile_home_repair", "movers", "packingservices", "painters", "patiocoverings", "plumbing", "backflowservices", "poolservice", "poolcleaners", "pressurewashers", "realestate", "apartments", "artspacerentals", "commercialrealestate", "condominiums", "estateliquidation", "homedevelopers", "homestaging", "homeownerassociation", "housingcooperatives", "kitchenincubators", "mobilehomes", "mobileparks", "mortgagebrokers", "propertymgmt", "realestateagents", "realestatesvcs", "landsurveying", "estatephotography", "sharedofficespaces", "university_housing", "refinishing", "roofinspectors", "roofing", "saunainstallation", "securitysystems", "blinds", "shutters", "vinylsiding", "solarinstallation", "solarpanelcleaning", "structuralengineers", "stucco", "televisionserviceproviders", "tiling", "treeservices", "utilities", "wallpapering", "waterheaterinstallrepair", "waterpurification", "waterproofing", "windowwashing", "windowsinstallation"]
    
    static let localFlavorsCategories = ["localflavor", "parklets", "publicart", "unofficialyelpevents", "yelpevents"]
    
    static let nightlifeCategories = ["nightlife", "adultentertainment", "stripclubs", "stripteasedancers", "barcrawl", "bars", "absinthebars", "airportlounges", "beachbars", "beerbar", "champagne_bars", "cigarbars", "cocktailbars", "divebars", "drivethrubars", "gaybars", "hookah_bars", "hotel_bar", "irish_pubs", "lounges", "pubs", "pulquerias", "sakebars", "speakeasies", "sportsbars", "tabac", "tikibars", "vermouthbars", "whiskeybars", "wine_bars", "beergardens", "clubcrawl", "coffeeshops", "comedyclubs", "countrydancehalls", "danceclubs", "dancerestaurants", "fasil", "jazzandblues", "karaoke", "musicvenues", "pianobars", "poolhalls"]
    
    static let landmarkCategories = ["publicservicesgovt", "authorized_postal_representative", "civiccenter", "communitycenters", "courthouses", "departmentsofmotorvehicles", "embassy", "firedepartments", "landmarks", "libraries", "municipality", "policedepartments", "postoffices", "registry_office", "taxoffice", "townhall"]
    
    static let shoppingCategories = ["shopping", "adult", "antiques", "galleries", "artsandcrafts", "artsupplies", "ateliers", "stationery", "cookingclasses", "costumes", "embroideryandcrochet", "fabricstores", "framing", "paintyourownpottery", "auctionhouses", "baby_gear", "batterystores", "bespoke", "media", "bookstores", "comicbooks", "musicvideo", "mags", "videogamestores", "videoandgames", "vinyl_records", "brewingsupplies", "bridal", "cannabisdispensaries", "chinesebazaar", "computers", "concept_shops", "cosmetics", "custommerchandise", "deptstores", "discountstore", "drugstores", "dutyfreeshops", "electronics", "opticians", "farmingequipment", "fashion", "accessories", "ceremonialclothing", "childcloth", "clothingrental", "deptstores", "formalwear", "furclothing", "hats", "kimonos", "leather", "lingerie", "maternity", "menscloth", "plus_size_fashion", "shoes", "sleepwear", "sportswear", "dancewear", "stockings", "surfshop", "swimwear", "tradclothing", "vintage", "womenscloth", "fireworks", "fitnessequipment", "fleamarkets", "flowers", "stationery", "florists", "giftshops", "goldbuyers", "guns_and_ammo", "headshops", "hifi", "hobbyshops", "homeandgarden", "appliances", "candlestores", "christmastrees", "furniture", "grillingequipment", "hardware", "holidaydecorations", "homedecor", "hottubandpool", "kitchenandbath", "linens", "materialeelettrico", "mattresses", "gardening", "hydroponics", "outdoorfurniture", "paintstores", "playsets", "pumpkinpatches", "rugs", "tableware", "horsequipment", "jewelry", "kiosk", "knittingsupplies", "livestocksupply", "luggage", "marketstalls", "medicalsupplies", "militarysurplus", "cellphoneaccessories", "mobilephones", "motorcyclinggear", "musicalinstrumentsandteachers", "officeequipment", "outlet_stores", "packingsupplies", "pawn", "perfume", "personal_shopping", "photographystores", "poolbilliards", "popupshops", "props", "publicmarkets", "religiousitems", "safestores", "safetyequipment", "scandinaviandesign", "shoppingcenters", "shoppingpassages", "souvenirs", "spiritual_shop", "sportgoods", "bikes", "diveshops", "golfequipment", "huntingfishingsupplies", "outdoorgear", "skateshops", "skishops", "sportswear", "dancewear", "tabletopgames", "teachersupplies", "thrift_stores", "tickets", "tobaccoshops", "toys", "trophyshops", "uniforms", "usedbooks", "vapeshops", "vitaminssupplements", "watches", "wholesale_stores", "wigs"]
    
    static let parksCategories = ["parks", "dog_parks", "skate_parks"]
}
