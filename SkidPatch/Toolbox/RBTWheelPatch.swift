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
let minSizeArc: Int        = 12

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
        println("skidPatchAmount : \(self.skidPatchAmount!)")
    }

    // MARK: - Drawing
    override func drawRect(rect: CGRect) {
        let radius: CGFloat = CGRectGetWidth(rect)/2
        self.drawWheelBase(radius)
        self.drawSkidArcs(radius)
        self.drawInnerCircle(radius)
        self.drawSpokes(radius)
    }
    
    private func drawWheelBase(radius: CGFloat) {
        var outerCircle: UIBezierPath  = UIBezierPath()
        var innerCircle: UIBezierPath  = UIBezierPath()
        let centerCircle: CGPoint = CGPoint(x: radius, y: radius)
        
        outerCircle.addArcWithCenter(centerCircle, radius: radius * 0.978, startAngle: CGFloat(startCircle), endAngle: CGFloat(completeCircle), clockwise: true)
        outerCircle.addLineToPoint(centerCircle)
        outerCircle.lineWidth = radius * 0.04
        UIColor.RBTRGray().setStroke()
        outerCircle.stroke()
        
        innerCircle.addArcWithCenter(centerCircle, radius: radius * 0.921, startAngle: CGFloat(startCircle), endAngle: CGFloat(completeCircle), clockwise: true)
        innerCircle.addLineToPoint(centerCircle)
        innerCircle.lineWidth = radius * 0.04
        UIColor.RBTRGrayLight().setStroke()
        innerCircle.stroke()
    }
    
    private func drawSpokes(radius: CGFloat) {
        var cursor: Double        = startCircle
        var spokeLength: CGFloat  = radius * 0.9
        let centerCircle: CGPoint = CGPoint(x: radius, y: radius)
        var next: CGPoint         = CGPoint()
        var intervalSpoke: Double = completeCircle / 32.0
        
        while (cursor < completeCircle) {
            var spoke: UIBezierPath = UIBezierPath()
            
            spoke.moveToPoint(centerCircle)
            next.x = centerCircle.x + spokeLength * CGFloat(cos(Float(cursor)))
            next.y = centerCircle.y + spokeLength * CGFloat(sin(Float(cursor)))
            spoke.addLineToPoint(next)
            spoke.stroke()
            
            cursor += intervalSpoke
        }
    }
    
    private func drawSkidArcs(radius: CGFloat) {
        var sizeArc: Double       = baselineArc
        let centerCircle: CGPoint = CGPoint(x: radius, y: radius)
        var next: CGPoint         = CGPoint()
        var arc: UIBezierPath     = UIBezierPath()
        var cursor: Double        = startCircle
        var minArcSize: Int       = (self.skidPatchAmount! > minSizeArc) ? minSizeArc : self.skidPatchAmount!
        var sizeInterval: Double
        
        for (var i: Int = 1; i < minArcSize; i++) {
            sizeArc *= 0.7
        }
        sizeInterval = (completeCircle - (sizeArc * Double(self.skidPatchAmount!))) / Double(self.skidPatchAmount!)
        
        while (cursor < completeCircle) {
            var currentArc: UIBezierPath = UIBezierPath()
            
            arc.moveToPoint(centerCircle)
            next.x = centerCircle.x + radius * CGFloat(cos(Float(cursor)))
            next.y = centerCircle.y + radius * CGFloat(sin(Float(cursor)))
            arc.addLineToPoint(next)
            arc.addArcWithCenter(centerCircle, radius: radius, startAngle: CGFloat(cursor), endAngle: CGFloat(cursor + sizeArc), clockwise: true)
            arc.addLineToPoint(centerCircle)
            UIColor.RBTRed().setFill()
            arc.fill()
            
            cursor += sizeArc + sizeInterval
        }
    }
    
    private func drawInnerCircle(radius: CGFloat) {
        var innerCircle : UIBezierPath = UIBezierPath()
        var centerCircle: CGPoint = CGPoint(x: radius, y: radius)
        
        innerCircle.addArcWithCenter(centerCircle, radius: radius*0.9, startAngle: CGFloat(startCircle), endAngle: CGFloat(completeCircle), clockwise: true)
        innerCircle.addLineToPoint(centerCircle)
        UIColor.whiteColor().setFill()
        innerCircle.fill()
    }

}
