import Foundation
import UIKit

protocol AlertPresentable {
    func showAlert(title: String?, message: String?)
}

extension AlertPresentable where Self: UIViewController {
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok",
                                                style: UIAlertActionStyle.default,
                                                handler: nil))
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
