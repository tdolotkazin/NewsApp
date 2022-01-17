import UIKit

extension UIView {
  func createShadow() {
    layer.cornerRadius = 8
    layer.masksToBounds = false
    layer.shadowRadius = 4
    layer.shadowOpacity = 0.5
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 4)
  }
}
