

import Foundation
import UIKit

enum LayoutConstants {
    static let leadingMargin: CGFloat = 16
    static let trailingMargin: CGFloat = -16
    static let indent: CGFloat = 16
    static let indentTwelve: CGFloat = 12
    static let cornerRadius: CGFloat = 12
    static let heightOfWillCell: CGFloat = 130

}

final class CustomButton: UIButton {
    var handlerButtonTapped: (() -> Void)?
    
    init(title: String = "",
         titleColor: UIColor = .black,
         backgroundColor: UIColor = .systemCyan) {
        
        super.init(frame: .zero)
        basicSettings()
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func basicSettings() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = LayoutConstants.cornerRadius
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.clipsToBounds = true
    }
    
    @objc private func buttonTapped() {
        (handlerButtonTapped ?? {})()
    }
}
