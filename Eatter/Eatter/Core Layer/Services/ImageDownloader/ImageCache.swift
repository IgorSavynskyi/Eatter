import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    // MARK: - Private
    private let cache = NSCache<NSString, UIImage>()
    private init() {}
}


extension ImageCache {
    subscript(key: URL) -> UIImage? {
        get {
            return cache.object(forKey: key.absoluteString as NSString)
        }
        set {
            if let image: UIImage = newValue {
                cache.setObject(image, forKey: key.absoluteString as NSString)
            } else {
                cache.removeObject(forKey: key.absoluteString as NSString)
            }
        }
    }
    
}
