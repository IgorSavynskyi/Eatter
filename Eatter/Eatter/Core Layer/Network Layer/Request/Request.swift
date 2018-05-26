import Foundation

class Request: RequestProtocol {
    var endpoint: String
    var method: RequestMethod?
    var headers: HeadersDict?
    var parameters: JSON?

    init(method: RequestMethod = .get, endpoint: String = "", params: JSON? = nil) {
        self.method = method
        self.endpoint = endpoint
        self.parameters = params
    }
}
