import UIKit

protocol KeyboardProtocol: class {
    func addKeyboardObserver()
    func removeKeyboardObserver()
    func keyboardWillShow(notification: Notification)
    func keyboardWillHide(notification: Notification)
}

extension KeyboardProtocol where Self: UIViewController {
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow,
                                               object: nil,
                                               queue: nil) { [weak self] notification in
                                                self?.keyboardWillShow(notification: notification)
        }
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide,
                                               object: nil,
                                               queue: nil) { [weak self] notification in
                                                self?.keyboardWillHide(notification: notification)
        }
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
}
