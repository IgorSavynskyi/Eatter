struct RestaurantsRequestParams {
    let code: String
}

extension RestaurantsRequestParams : JSONSerializable {
    var toJson: JSON {
        return ["q": code]
    }
}
