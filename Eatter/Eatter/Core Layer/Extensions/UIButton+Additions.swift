import UIKit

extension UIButton {
    @discardableResult func cornerRadius(_ radius: CGFloat) -> UIButton {
        self.layer.cornerRadius = radius
        return self
    }
    
    @discardableResult func backgroundColor(_ color: UIColor) -> UIButton {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult func titleColor(_ color: UIColor, for state: UIControlState) -> UIButton {
        self.setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult func font(_ font: UIFont) -> UIButton {
        self.titleLabel?.font(font)
        return self
    }
}

