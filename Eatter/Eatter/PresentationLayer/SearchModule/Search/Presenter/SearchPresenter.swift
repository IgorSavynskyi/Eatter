class SearchPresenter {
    // MARK: - Props
    weak var view: SearchViewInput!
    weak var flowDelegate: SearchFlowDelegate?
    
    // MARK: - Private Props
    private let restService = RestaurantsService()

    // MARK: - Private API
    private func handlePostcodeFailure(with error: LocationError) {
        switch error {
        case .commonError(let errorDescription):
            view.showCommonInfo(errorDescription)
        case .accessDenied:
            view.showEditLocationPermissionsAlert()
        }
    }
    
}


extension SearchPresenter: SearchViewOutput {
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func didSearchAction(for code: String?) {
        guard let code = code, Validator.isValidPostCode(code) else { return }
        let params = RestaurantsRequestParams(code: code)
        restService.getRestaurants(with: params) {[weak self] (result) in
            switch result {
            case .success(let items):
                self?.flowDelegate?.didReceiveRastaurants(items)
            case .failure(let error):
                self?.view.showAlert(title: nil, message: error.localizedDescription)
            }
        }
    }
    
    func findLocationPostcodeAction() {
        LocationService.shared.getUserPostalCode { (result) in
            switch result {
            case .success(let code):
                self.view.renderPostalCode(code)
            case .failure(let error):
                self.handlePostcodeFailure(with: error)
            }
        }
    }

}
