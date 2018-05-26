import UIKit

class SearchCoordinator {
    // MARK: - Private Props
    private let navigator: Navigator
    
    // MARK: - API
    init(rootVC: UINavigationController) {
        self.navigator = Navigator.init(navigationController: rootVC)
    }
    
    // MARK: - Private API
    private func runSearchModule() {
        let presenter = SearchPresenter()
        let vc = ViewControllerFactory.makeSearchViewController(with: presenter)
        navigator.showNavigationBar(false)
        navigator.navigate(to: vc, transition: .root)
    }
    
}

extension SearchCoordinator: Coordinator {
    func start() {
        runSearchModule()
    }
}

