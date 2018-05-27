import UIKit

class ResultsViewController: UIViewController {
    private enum Layout {
        static let itemHeigh: CGFloat = 120
        static let padding: CGFloat = 16
    }
    
    // MARK: - Props
    var output: ResultsViewOutput!
    
    // MARK: - Private Props
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: [PlaceViewModel] = [] { didSet { collectionView.reloadData() } }
    
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
        dataSource = places
    }

}


// MARK: - UICollectionViewDataSource
extension ResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let place = dataSource[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCell.defaultReuseIdentifier, for: indexPath) as! PlaceCell
        cell.renderPlace(place)
        return cell
    }
    
}

extension ResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }

}




// MARK: - UICollectionViewDelegateFlowLayout
extension ResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 2*Layout.padding, height: Layout.itemHeigh)
    }
}

