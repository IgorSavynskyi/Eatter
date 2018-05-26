import Foundation
import UIKit

extension String {
    func stringByAdding(urlEncodedFields fields: JSON?) throws -> String {
        guard let f = fields else { return self }
        return try f.urlEncodedString(base: self)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedStringKey.font: font],
                                            context: nil)
        return ceil(boundingBox.height)
    }
    
}
