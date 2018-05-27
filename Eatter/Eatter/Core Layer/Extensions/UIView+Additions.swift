import UIKit

extension UIView {
    func applyDefaultStyleShadow(_ cornerRadius: CGFloat) {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowOffset = CGSize.init(width: 0, height: 2)
        layer.shadowOpacity = 1.0
        layer.shadowPath = shadowPath.cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
    }
}
