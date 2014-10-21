//
//  Calculation.swift
//  SkidPatch
//
//  Created by Romain Bousquet on 12/10/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

import UIKit

class Calculation: NSObject {
    
    private class func gcd(a: Int, b: Int) -> Int {
        var c: Int
        var tmpA: Int = a
        var tmpB: Int = b
        while (tmpA != 0) {
            c = tmpA
            tmpA = tmpB % tmpA
            tmpB = c
        }
        return tmpB
    }
    
    class func reducedRatio(dPlat: Int, dPign: Int) -> (reducedPlat: Int, reducedPign: Int) {
        var gcd: Int = Calculation.gcd(dPlat, b: dPign)
        return (dPlat / gcd, dPign / gcd)
    }
    
    class func skidPatchNumber(dPlat: Int, dPign: Int) -> Int {
        var gcd: Int = Calculation.gcd(dPlat, b: dPign)
        var simpDPlat: Int = dPlat / gcd
        var simpDPign: Int = dPign / gcd
        return simpDPign
    }
    
}