protocol ResultsViewInput: class {
    func setupInitialState()
    func renderPlaces(_ places: [PlaceViewModel])
}

protocol ResultsViewOutput {
    func viewIsReady()
}
