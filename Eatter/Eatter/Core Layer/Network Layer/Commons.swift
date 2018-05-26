enum Result<Value> {
    case success(Value)
    case failure(NetworkError)
}

typealias HeadersDict = [String: String]
typealias JSON = [String : Any]
