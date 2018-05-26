import Foundation

class SearchPresenter {
    weak var view: SearchViewInput!
}


extension SearchPresenter: SearchViewOutput {
    func viewIsReady() {
        view.setupInitialState()
    }
}
