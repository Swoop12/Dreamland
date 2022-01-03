//
//  PieSection.swift
//  Taro
//
//  Created by DevMountain on 11/28/20.
//

import SwiftUI

struct RoundedPieSection: Shape {
    
    // MARK: - Properties
    let fraction: Double
    let totalAngle: Double
    let centerPadding: CGFloat
    
    // MARK: - Initializers
    init(fraction: Double, totalAngle: Double = 180, centerPadding: CGFloat = 20) {
        self.fraction = fraction
        self.totalAngle = totalAngle
        self.centerPadding = centerPadding
    }
    
    // MARK: - Shpae
    func path(in rect: CGRect) -> Path {
        let cornerRadius = rect.width * 0.04
        let trueCenter = CGPoint(x: rect.midX, y: rect.midY)
        let startPoint = CGPoint(x: rect.midX + centerPadding, y: rect.midY)
        let radius = rect.width/2
        var path = Path()
        var guidePath = Path()
        guidePath.move(to: trueCenter)
        guidePath.addLine(to: CGPoint(x: rect.minX + radius, y: rect.midY))
        guidePath.addArc(center: trueCenter,
                         radius: radius,
                         startAngle: .degrees(0),
                         endAngle: .degrees((totalAngle * fraction)),
                         clockwise: false)
        let secondPeak = guidePath.currentPoint!
        guidePath.addLine(to: trueCenter)
        let deltaY = trueCenter.y - secondPeak.y
        let deltaX = trueCenter.x - secondPeak.x
        let secondSlope = deltaY / deltaX
        
        let secondPeakShift = relativeShift(slope: secondSlope, magnitude: cornerRadius)
        let inflectionPoint = CGPoint(x: secondPeak.x - secondPeakShift.x, y: secondPeak.y - secondPeakShift.y)
        
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.midY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY + cornerRadius),
                          control: CGPoint(x: rect.maxX, y: rect.midY))
        
        let circumference = 2 * CGFloat.pi * radius
        let degreesPadding = Double(cornerRadius/circumference) * 360
        path.addArc(center: trueCenter,
                    radius: radius,
                    startAngle: .degrees(degreesPadding),
                    endAngle: .degrees((totalAngle * fraction) - degreesPadding),
                    clockwise: false)
//        guidePath.addLine(to: center)
        path.addQuadCurve(to: inflectionPoint,
                          control:  secondPeak)
        let endPointShift = relativeShift(slope: secondSlope, magnitude: centerPadding)
        let endingPoint = CGPoint(x: trueCenter.x + endPointShift.x,
                                  y: trueCenter.y + endPointShift.y)
        path.addLine(to: endingPoint)
        path.addQuadCurve(to: startPoint, control: trueCenter)
        return path
    }
    
    
    // MARK: - Helper Methods
    private func relativeShift(slope: CGFloat, magnitude: CGFloat) -> CGPoint {
        let slopePlus = slope + 1
        let magnitude = magnitude * magnitude
        let xShift = (magnitude/slopePlus).squareRoot()
        let yShift = xShift * slope
        return CGPoint(x: xShift, y: yShift)
    }
}

struct PieSection_Previews: PreviewProvider {
    static var previews: some View {
        RoundedPieSection(fraction: 0.25)
    }
}
