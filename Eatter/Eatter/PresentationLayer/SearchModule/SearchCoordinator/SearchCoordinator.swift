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
        navigator.navigate(to: vc, transition: .push)
    }
    
}

extension SearchCoordinator: Coordinator {
    func start() {
        runSearchModule()
    }
}

//extension LandingCoordinator: FeedModuleDelegate {
//    func openUrl(_ url: URL) {
//        navigator.navigate(to: .webPage(url), transition: .modal)
//    }
//}
