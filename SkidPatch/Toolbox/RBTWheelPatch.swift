//
//  RBTWheelPatch.swift
//  SkidPatch
//
//  Created by Romain Bousquet on 13/10/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

import UIKit

let completeCircle: Double = M_PI*2
let baselineArc: Double    = (M_PI/2)*0.8
let startCircle: Double    = 0

class RBTWheelPatch: UIView {
    
    var dPlat: Int?
    var dPign: Int?
    var skidPatchAmount: Int?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, sizePlateau: Int, sizePignon: Int) {
        super.init(frame: frame)
        self.dPlat = sizePlateau
        self.dPign = sizePignon
        self.skidPatchAmount = Calculation.skidPatchNumber(sizePlateau, dPign: sizePignon, isAmbidextrous: false)
    }

    // MARK: - Drawing
    override func drawRect(rect: CGRect) {
        let radius: CGFloat = CGRectGetWidth(rect)/2
        self.drawOuterArcs(radius)
//        self.drawInnerCircle(radius)
    }
    
    private func drawOuterArcs(radius: CGFloat) {
        var sizeArc: Double
        let endArc: Double        = (M_PI/2)*0.8 // /skidPatchAmount
        let centerCircle: CGPoint = CGPoint(x: radius, y: radius)
        var next: CGPoint         = CGPoint()
        var arc: UIBezierPath     = UIBezierPath()
        
        arc.moveToPoint(centerCircle)
        next.x = centerCircle.x + radius * CGFloat(cos(Float(startCircle)))
        next.y = centerCircle.y + radius * CGFloat(sin(Float(startCircle)))
        arc.addLineToPoint(next)
        arc.addArcWithCenter(centerCircle, radius: radius, startAngle: CGFloat(startCircle), endAngle: CGFloat(endArc), clockwise: true)
        arc.addLineToPoint(centerCircle)
        UIColor.yellowColor().setFill()
        arc.fill()
    }
    
    private func drawInnerCircle(radius: CGFloat) {
        var innerCircle : UIBezierPath = UIBezierPath()
        var centerCircle: CGPoint = CGPoint(x: radius, y: radius)
        
        innerCircle.addArcWithCenter(centerCircle, radius: radius*0.9, startAngle: CGFloat(startCircle), endAngle: CGFloat(completeCircle), clockwise: true)
        innerCircle.addLineToPoint(centerCircle)
        UIColor.blueColor().setFill()
        innerCircle.fill()
    }

}
