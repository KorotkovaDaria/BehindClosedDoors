//
//  BCDTitleLabel.swift
//  BehindClosedDoors
//
//  Created by Daria on 08.05.2024.
//

import UIKit

class BCDTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (textAlignment: NSTextAlignment, color: UIColor?) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.textColor = color
    }
    
    private func configure() {
        font = UIFont.boldSystemFont(ofSize: 22)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byWordWrapping
    }
}
