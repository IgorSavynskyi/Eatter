import UIKit

class ViewControllerFactory {
    static func makeSearchViewController(with presenter: SearchPresenter) -> UIViewController {
        let vc: SearchViewController = Storyboard.main.instantiateViewController()
        vc.output = presenter
        presenter.view = vc
        return vc
    }
    
    static func makeResultsViewController(with presenter: ResultsPresenter) -> UIViewController {
        let vc: ResultsViewController = Storyboard.main.instantiateViewController()
        vc.output = presenter
        presenter.view = vc
        return vc
    }

}
