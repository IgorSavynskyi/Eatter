import XCTest
@testable import Eatter

class EatterNetworkingTests: XCTestCase {
    var restService: RestaurantsService!
    var imageDownloader: ImageDownloader!

    override func setUp() {
        super.setUp()
        restService = RestaurantsService()
        imageDownloader = ImageDownloader()
    }
    
    override func tearDown() {
        restService = nil
        imageDownloader = nil
        super.tearDown()
    }
    
    func testDefaultOutcodeFetching() {
        let params = RestaurantsRequestParams(code: "se19")
        let promise = expectation(description: "Fetching success")
        
        restService.getRestaurants(with: params) {(result) in
            switch result {
            case .success(let items):
                if items.count > 0 {
                    promise.fulfill()
                } else {
                    XCTFail("No items fetched")
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    func testInvalidPostcodeFetching() {
        let params = RestaurantsRequestParams(code: "!@$$%ˆˆ%26%26*")
        let promise = expectation(description: "Completion handler invoked")
        var responseItems: [RestaurantItem]?
        var responseError: NetworkError?
        
        restService.getRestaurants(with: params) {(result) in
            switch result {
            case .success(let items):
                responseItems = items
            case .failure(let error):
                responseError = error
            }
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertNil(responseItems)
        XCTAssertNotNil(responseError)
    }
    
    // Performance
    func testDownloadImagePerformance() {
        measure {
            guard let largeImageUrl = URL(string: "https://i.redd.it/q9rhs4bx52011.jpg") else { return }
            imageDownloader.downloadImage(from: largeImageUrl, completion: {_ in })
        }
    }
    
}

