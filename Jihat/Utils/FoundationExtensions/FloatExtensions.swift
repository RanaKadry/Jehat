//
//  FloatExtensions.swift
//  Driver
//
//  Created by Peter Bassem on 27/12/2020.
//  Copyright © 2020 Eslam Maged. All rights reserved.
//

import Foundation

extension Float64 {
    
    func toInt() -> Int {
        return Int(self)
    }
}

extension Float {
 
    func toString() -> String {
        return String(self)
    }
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Self {
        let divisor = pow(10.0, Double(places))
        return Float((Double(self) * divisor).rounded() / divisor)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
}

extension Float {

    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    static var random: Float {
        return Float(arc4random()) / 0xFFFFFFFF
    }

    /// Random float between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random float point number between 0 and n max
    static func random(min: Float, max: Float) -> Float {
        return Float.random * (max - min) + min
    }
}
