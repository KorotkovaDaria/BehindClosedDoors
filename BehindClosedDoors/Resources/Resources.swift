//
//  Resources.swift
//  BehindClosedDoors
//
//  Created by Daria on 08.05.2024.
//

import Foundation

import UIKit

enum Resources {
    enum Colors {
        static let green = UIColor(named: "green")
        static let pink  = UIColor(named: "pink")
        static let red   = UIColor(named: "red")

    }
    
    enum ImageTitle {
        static let zeroStar  = UIImage(named: "0")
        static let oneStar   = UIImage(named: "1")
        static let twoStar   = UIImage(named: "2")
        static let threeStar = UIImage(named: "3")
        static let fourStar  = UIImage(named: "4")
        static let fiveStar  = UIImage(named: "5")
        
        static let placeholderImage = UIImage(named: "plaseholderImage")
        static let arrowUpBackward  = UIImage(systemName: "arrow.backward")
        static let arrowSorted      = UIImage(systemName: "arrow.up.arrow.down")
        static let xmark            = UIImage(systemName: "xmark")
        
    }
    
    enum Condition {
        static let sortLtoS = "sort from larger to smaller"
        static let sortStoL = "sort from smaller to larger"
        static let sortDef  = "sort by default"
    }

    enum Sort {
        static let byDefault = "default"
        static let byRooms = "number of available rooms"
        static let byDistance = "distance from the city center"
        
    }
    
    enum AlertText {
        static let titleWrongAlert = "You wrote something wrong!"
        static let messageTextAlert = "Please make sure you make your request.\n"
        static let okButtonTitleAlert = "OK"
    }
}
