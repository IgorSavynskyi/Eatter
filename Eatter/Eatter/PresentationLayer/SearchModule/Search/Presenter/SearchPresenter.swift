import Foundation

class SearchPresenter {
    weak var view: SearchViewInput!
    
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
