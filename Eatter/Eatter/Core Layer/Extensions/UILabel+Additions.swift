import UIKit

extension UILabel {
    @discardableResult func font(_ font: UIFont) -> UILabel {
        self.font = font
        return self
    }
    
    @discardableResult func textColor(_ textColor: UIColor) -> UILabel {
        self.textColor = textColor
        return self
    }

}

