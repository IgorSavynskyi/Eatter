protocol SearchViewInput: class, AlertPresentable {
    func setupInitialState()
    func renderPostalCode(_ code: String?)
    func showEditLocationPermissionsAlert()
    func showCommonInfo(_ info: String)
}

protocol SearchViewOutput {
    func viewIsReady()
    func didSearchAction(for code: String?)
    func findLocationPostcodeAction()
}
