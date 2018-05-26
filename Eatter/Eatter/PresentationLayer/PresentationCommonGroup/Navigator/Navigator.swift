import UIKit

class Navigator {
    enum TransitionType {
        case push
        case modal
    }
    
    private let navigationController: UINavigationController
    
    // MARK: - API
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigate(to viewController: UIViewController, transition: TransitionType) {
        switch transition {
        case .push:
            navigationController.pushViewController(viewController, animated: true)
        case .modal:
            navigationController.present(viewController, animated: true, completion: nil)
        }
    }

    func showNavigationBar(_ value: Bool) {
        navigationController.isNavigationBarHidden = !value
    }
    
}
