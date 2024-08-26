//
//  UIImage + croppedImage.swift
//  BehindClosedDoors
//
//  Created by Daria on 14.05.2024.
//

import UIKit

extension UIImage {
    func croppedImage(withInsets insets: UIEdgeInsets) -> UIImage? {
        guard let cgImage = cgImage else { return nil }
        let croppedCGImage = cgImage.cropping(to: CGRect(x: insets.left * scale,
                                                         y: insets.top * scale,
                                                         width: (size.width - insets.left - insets.right) * scale,
                                                         height: (size.height - insets.top - insets.bottom) * scale))
        return croppedCGImage.map { UIImage(cgImage: $0, scale: scale, orientation: imageOrientation) }
    }

}
