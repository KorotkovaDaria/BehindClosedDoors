//
//  Srtring + Ext.swift
//  BehindClosedDoors
//
//  Created by Daria on 12.05.2024.
//

import Foundation

extension String {
    func extractAvailableSuitesCount() -> [Int] {
        return self.components(separatedBy: ":").compactMap { Int($0) }
    }
}
