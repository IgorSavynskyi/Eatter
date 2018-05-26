import UIKit

private extension Selector {
    static let handleTap = #selector(SearchViewController.handleTap(_:))
}

class SearchViewController: UIViewController {
    private enum Settings {
        static let shortAnimationDuration = 0.25
        static let longAnimationDuration = 0.5
        static let defaultCornerRadius: CGFloat = 4
    }
    
    // MARK: - Props
    var output: SearchViewOutput!
    
    // MARK: - Private Props
    @IBOutlet weak private var logoLabel: UILabel!
    @IBOutlet weak private var sloganLabel: UILabel!
    @IBOutlet weak private var searchView: UIStackView!
    
    @IBOutlet weak private var searchInputContainerView: UIView!
    @IBOutlet weak private var searchHintLabel: UILabel!
    @IBOutlet weak private var searchField: UITextField!
    private lazy var tapRecognizer = makeTapGestureRecognizer()
    
    @IBOutlet weak var searchButton: UIButton!
    var isValidPostcode: Bool { return Validator.isValidPostCode(searchField.text) }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fireAppearance()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObserver()
    }
    
    // MARK: - Private API
    
    private func updateSearchButtonState() {
        searchButton.isEnabled = isValidPostcode
        UIView.animate(withDuration: Settings.shortAnimationDuration) {
            self.searchButton.alpha = self.searchButton.isEnabled ? 1.0 : 0.5
        }
    }
    
    private func fireAppearance() {
        self.searchField.becomeFirstResponder()
        UIView.animate(withDuration: Settings.longAnimationDuration) {
            self.searchView.alpha = 1
        }
    }
    
    private func setupLogoViewStyle() {
        logoLabel.font(.headerFont)
            .textColor(.headlineColor)
        
        sloganLabel.font(.titleFont)
            .textColor(.headlineColor)
    }
    
    private func setupSearchViewStyle() {
        searchInputContainerView.backgroundColor = .fieldBackgroundColor
        searchInputContainerView.layer.cornerRadius = Settings.defaultCornerRadius
        
        searchHintLabel
            .font(.titleFont)
            .textColor(.textColor)
        
        searchField
            .font(.titleFont)
            .textColor(.textColor)
        
        searchButton
            .cornerRadius(Settings.defaultCornerRadius)
            .backgroundColor(.headlineColor)
            .titleColor(.white, for: .normal)
            .font(.titleFont)
    }
    
    private func makeTapGestureRecognizer() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: .handleTap)
    }
    
    @objc fileprivate func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: - Actions
    @IBAction private func pickLocationPostcodeAction(_ sender: Any) {
    }
    
    @IBAction private func searchAction(_ sender: Any) {
    }
    
    @IBAction func searchFieldEditingChanged(_ sender: Any) {
        print(#function)
        updateSearchButtonState()
    }
	
}

extension SearchViewController: SearchViewInput {
    func setupInitialState() {
        setupLogoViewStyle()
        
        setupSearchViewStyle()
        updateSearchButtonState()
        searchView.alpha = 0
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SearchViewController: KeyboardProtocol {
    func keyboardWillShow(notification: Notification) {
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func keyboardWillHide(notification: Notification) {
        view.removeGestureRecognizer(tapRecognizer)
    }
}
