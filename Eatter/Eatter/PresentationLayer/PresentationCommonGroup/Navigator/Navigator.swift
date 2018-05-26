import UIKit

class Navigator {
    enum TransitionType {
        case root, push, modal
    }
    
    private let navigationController: UINavigationController
    
    // MARK: - API
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigate(to destination: UIViewController, transition: TransitionType) {
        switch transition {
        case .root:
            navigationController.setViewControllers([destination], animated: false)
        case .push:
            navigationController.pushViewController(destination, animated: true)
        case .modal:
            navigationController.present(destination, animated: true, completion: nil)
        }
    }
    
}
