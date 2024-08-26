//
//  BCDBodyLabel.swift
//  BehindClosedDoors
//
//  Created by Daria on 08.05.2024.
//

import UIKit

class BCDBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        cofigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (textAlignment: NSTextAlignment, color: UIColor?) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.textColor = color
    }
    
    private func cofigure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
    }
}
