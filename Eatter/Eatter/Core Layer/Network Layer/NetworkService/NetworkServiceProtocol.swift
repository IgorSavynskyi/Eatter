protocol NetworkServiceProtocol {
    var configuration: ServerConfig { get }
    var headers: HeadersDict { get }

    init(_ configuration: ServerConfig)
    func execute<Response>(_ request: RequestProtocol, completion: @escaping (_ result: Result<Response>) -> ()) where Response: Codable
}

