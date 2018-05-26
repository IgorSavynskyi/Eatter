import Foundation

class ResultsPresenter {
    weak var view: ResultsViewInput!
    private var places: [PlaceViewModel]
    
    init(with items: [RestaurantItem]) {
        self.places = items.map { PlaceViewModel(with: $0) }
    }
}


extension ResultsPresenter: ResultsViewOutput {
    func viewIsReady() {
        view.setupInitialState()
        view.renderPlaces(places)
    }

}
