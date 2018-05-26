import UIKit

extension UITextField {
    @discardableResult func font(_ font: UIFont) -> UITextField {
        self.font = font
        return self
    }
    
    @discardableResult func textColor(_ textColor: UIColor) -> UITextField {
        self.textColor = textColor
        return self
    }
    
}
