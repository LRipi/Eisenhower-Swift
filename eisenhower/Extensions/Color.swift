//
//  Color.swift
//  eisenhower
//
//  Created by Léo Riberon-Piatyszek on 30/01/2020.
//  Copyright © 2020 epitech. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

extension Color {
    static func random() -> Color {
        return Color(UIColor.random())
    }
}
