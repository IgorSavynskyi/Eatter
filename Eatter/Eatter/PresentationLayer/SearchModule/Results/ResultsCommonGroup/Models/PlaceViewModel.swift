struct PlaceViewModel {
    let name: String
    let ratingAverage: Float?
    let id: Int
    let cuisineTypes: [String]
    let logo: String?
    let isOpenNow: Bool
}

extension PlaceViewModel {
    init(with restaurant: RestaurantItem) {
        self.name = restaurant.name ?? ""
        self.ratingAverage = restaurant.ratingAverage ?? 0
        self.id = restaurant.id ?? 0
        
        if let cuisineTypes = restaurant.cuisineTypes {
            self.cuisineTypes = cuisineTypes.compactMap { $0.name }
        } else {
            self.cuisineTypes = []
        }
        
        if let logo = restaurant.logo, let mainLogo = logo.first {
            self.logo = mainLogo.standardResolutionURL
        } else {
            self.logo = nil
        }
        
        self.isOpenNow = restaurant.isOpenNow ?? false
    }
}
