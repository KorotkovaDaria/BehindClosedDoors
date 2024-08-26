//
//  AlertContainerView.swift
//  BehindClosedDoors
//
//  Created by Daria on 13.05.2024.
//

import UIKit

class AlertContainerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = Resources.Colors.pink
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = Resources.Colors.green?.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
