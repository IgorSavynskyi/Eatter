import UIKit

private extension Selector {
    static let handleTap = #selector(SearchViewController.handleTap(_:))
}

class SearchViewController: UIViewController {
    private enum Settings {
        static let shortAnimationDuration: TimeInterval = 0.25
        static let longAnimationDuration: TimeInterval = 0.5
        static let defaultCornerRadius: CGFloat = 4
        static let infoPresentationDuration: TimeInterval = 4
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
    @IBOutlet weak private var infoLabel: UILabel!
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
        navigationController?.isNavigationBarHidden = true
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
        searchField.becomeFirstResponder()
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
        
        applyStyle(font: .smallFont, textColor: .textColor, to: searchHintLabel, infoLabel)
        
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
        output.findLocationPostcodeAction()
    }
    
    @IBAction private func searchAction(_ sender: Any) {
        output.didSearchAction(for: searchField.text)
    }
    
    @IBAction func searchFieldEditingChanged(_ sender: Any) {
        updateSearchButtonState()
    }
    
    fileprivate func goToSettingsHandler(_ action: UIAlertAction) {
        if let URL = URL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.shared.open(URL, options: [:], completionHandler: nil)
        }
    }
	
}

extension SearchViewController: SearchViewInput {
    func setupInitialState() {
        setupLogoViewStyle()
        
        setupSearchViewStyle()
        updateSearchButtonState()
        searchView.alpha = 0
        infoLabel.alpha = 0
    }
    
    func renderPostalCode(_ code: String?) {
        searchField.text = code
        updateSearchButtonState()
    }
    
    func showEditLocationPermissionsAlert() {
        let controller = UIAlertController(title: "Change location settings?",
                                           message: "Eatter uses location to find takeaways close to you",
                                           preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        controller.addAction(cancelAction)
        
        let settingsAction = UIAlertAction(title: "Go to Settings",
                                           style: .default,
                                           handler: goToSettingsHandler)
        controller.addAction(settingsAction)
        
        present(controller, animated: true, completion: nil)
    }

    func showCommonInfo(_ info: String) {
        infoLabel.text = info
        let processDuration = 0.2/Settings.infoPresentationDuration
        UIView.animateKeyframes(withDuration: Settings.infoPresentationDuration, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: processDuration, animations: {
                self.infoLabel.alpha = 1.0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1 - processDuration, relativeDuration: processDuration, animations: {
                self.infoLabel.alpha = 0.0
            })
        }, completion: nil)
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
