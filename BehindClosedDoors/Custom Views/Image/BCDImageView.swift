//
//  BCDImageView.swift
//  BehindClosedDoors
//
//  Created by Daria on 13.05.2024.
//

import UIKit

class BCDImageView: UIImageView {
    let cache = NetworkManager.shared.cache
    let placeholderImage = Resources.ImageTitle.placeholderImage
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.borderWidth = 2
        layer.borderColor = Resources.Colors.green?.cgColor
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        contentMode = .scaleToFill
    }
}
