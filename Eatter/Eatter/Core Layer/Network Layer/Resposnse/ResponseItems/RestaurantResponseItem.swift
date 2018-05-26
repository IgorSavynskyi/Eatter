import Foundation

struct RestaurantResponseItem: Codable {
    let restaurants: [RestaurantItem]
    
    enum CodingKeys: String, CodingKey {
        case restaurants = "Restaurants"
    }
}

extension RestaurantResponseItem {
    struct RestaurantItem: Codable {
        let name: String?
        let ratingAverage: Float?
        let id: Int?
        let cuisineTypes: [CuisineTypes]?
        let logo: [ImageItem]?
        let isOpenNow: Bool?
        
        enum CodingKeys: String, CodingKey {
            case name = "Name"
            case ratingAverage = "RatingAverage"
            case id = "Id"
            case cuisineTypes = "CuisineTypes"
            case logo = "Logo"
            case isOpenNow = "IsOpenNow"
        }
    }
    
    struct CuisineTypes: Codable {
        let id: Int?
        let name: String?
        
        enum CodingKeys: String, CodingKey {
            case id = "Id"
            case name = "Name"
        }
    }
    
    struct ImageItem: Codable {
        let standardResolutionURL: String
        
        enum CodingKeys: String, CodingKey {
            case standardResolutionURL = "StandardResolutionURL"
        }
    }
}
