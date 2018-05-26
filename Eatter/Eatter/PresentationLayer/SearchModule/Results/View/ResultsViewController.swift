import UIKit

class ResultsViewController: UIViewController {
    // MARK: - Props
    var output: ResultsViewOutput!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}


extension ResultsViewController: ResultsViewInput {
    func setupInitialState() {

    }
    
    func renderPlaces(_ places: [PlaceViewModel]) {

    }

}
