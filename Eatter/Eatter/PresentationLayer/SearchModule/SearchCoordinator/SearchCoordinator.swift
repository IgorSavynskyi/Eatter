import UIKit

class SearchCoordinator {
    // MARK: - Private Props
    private let navigator: Navigator
    
    // MARK: - API
    init(rootVC: UINavigationController) {
        self.navigator = Navigator(navigationController: rootVC)
        styleRootVC(rootVC)
    }
    
    // MARK: - Private API
    private func startSearchStory() {
        let presenter = SearchPresenter()
        presenter.flowDelegate = self
        let vc = ViewControllerFactory.makeSearchViewController(with: presenter)
        navigator.navigate(to: vc, transition: .root)
    }
    
    private func startResultsStory(_ items: [RestaurantItem]) {
        let presenter = ResultsPresenter(with: items)
        let vc = ViewControllerFactory.makeResultsViewController(with: presenter)
        navigator.navigate(to: vc, transition: .push)
    }
    
    private func styleRootVC(_ rootVC: UINavigationController) {
        rootVC.navigationBar.tintColor = .headlineColor
        rootVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textColor]

    }
    
}

extension SearchCoordinator: Coordinator {
    func start() {
        self.startSearchStory()
    }
}


extension SearchCoordinator: SearchFlowDelegate {
    func didReceiveRastaurants(_ items: [RestaurantItem]) {
        DispatchQueue.main.async {
            self.startResultsStory(items)
        }
    }
}
