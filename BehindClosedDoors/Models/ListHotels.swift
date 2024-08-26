//
//  ListHotels.swift
//  BehindClosedDoors
//
//  Created by Daria on 08.05.2024.
//

import Foundation

struct ListHotels: Codable, Hashable {
    let id: Int
    let name: String
    let address: String
    let stars: Int
    let distance: Double
    let suitesAvailability: String
}
