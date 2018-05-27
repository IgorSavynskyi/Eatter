import Foundation
import UIKit

typealias DownloadCompletion = (Result<UIImage>) -> Void

class ImageDownloader {
    static let defaultSession = ImageDownloader.makeDefaultSession()
    
    private var completion: DownloadCompletion?
    private var session = URLSession.shared
    private var currentTask: URLSessionDataTask?
    
    // MARK: - API
    func downloadImage(from url: URL, completion: @escaping DownloadCompletion) {
        self.completion = completion
        
        currentTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            AppService.shared.showNetworkActivity = false
            if error == nil {
                if let data = data, let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(NetworkError.common("Image failed to decode")))
                }
            } else {
                completion(.failure(NetworkError.common(error?.localizedDescription)))
            }
        })
        
        AppService.shared.showNetworkActivity = true
        currentTask?.resume()
    }
    
    func cancelDownload() {
        self.completion = nil
        currentTask?.cancel()
    }
    
    // MARK: - Private API
    static private func makeDefaultSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration)
    }
}
