import Foundation

typealias NetworkClientCompletion = (_ response: ServerResponse) -> Void

class NetworkClient {
    private let session: URLSession
    
    init(urlSession: URLSession) {
        self.session = urlSession
    }
    
    func send(_ request: URLRequest, completionHandler: @escaping NetworkClientCompletion) {
        let task = session.dataTask(with: request) {
            completionHandler(ServerResponse(data: $0, urlResponse: $1, error: $2, request: request))
        }
        task.resume()
    }
}
