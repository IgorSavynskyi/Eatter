import Foundation

typealias RestaurantItem = RestaurantResponseItem.RestaurantItem
class RestaurantsService {
    typealias RestaurantsCompletion = (Result<[RestaurantItem]>) -> ()
    
    // MARK: - Private Props
    private var networkService = NetworkService()
    
    // MARK: - API
    func getRestaurants(with params: RestaurantsRequestParams, completion: @escaping RestaurantsCompletion) {
        let request = Request(method: .get, endpoint: EndPoint.restaurants, params: params.toJson)
        
        networkService.execute(request) { (result: Result<RestaurantResponseItem>) in
            switch result {
            case .success(let response):
                completion(.success(response.restaurants))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
