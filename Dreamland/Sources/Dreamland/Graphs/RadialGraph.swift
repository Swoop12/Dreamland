//
//  RadialGraph.swift
//  Taro
//
//  Created by DevMountain on 11/28/20.
//

import SwiftUI

public struct RadialGraph: View {
    
    let x: Double
    let y: Double
    let z: Double
    
    let fillAngle: Double
    let spaceAngle: Double
    
    public init(x: Double,
                y: Double,
                z: Double,
                fillAngle: Double = 180,
                spaceAngle: Double = 360,
                stroke: Bool = false) {
        self.x = x
        self.y = y
        self.z = z
        self.fillAngle = fillAngle
        self.spaceAngle = spaceAngle
        self.stroke = stroke
    }
    
    let stroke: Bool
    
    var sum: Double {
        x + y + z
    }
    
    var xFraction: Double {
        x / sum
    }
    
    var yFraction: Double {
        (z / sum) * 1.1
    }
    
    var zFraction: Double {
        (z / sum) * 1.1
    }
    
    var max: Double {
        return [x, y, z].max()!
    }
    
    func frameProportion(for variable: Double) -> CGFloat {
        return CGFloat(variable / max)
    }
    
    func rotation(for fraction: Double, index: Int) -> Angle {
        let pieSliceDegrees = fillAngle * fraction
        let halfPieSlice = pieSliceDegrees / 2
        let positiveRotation = (spaceAngle/3) * Double(index)
        let rotationDegrees = positiveRotation - 145 - halfPieSlice
        return Angle.degrees(rotationDegrees)
    }
    
    public var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                
                if stroke {
                    RoundedPieSection(fraction: xFraction, totalAngle: fillAngle)
                        .rotation(rotation(for: xFraction, index: 0))
                        .stroke(Color.red)
                        .frame(width: geometry.size.width * frameProportion(for: x),
                               height: geometry.size.height * frameProportion(for: x))
                } else {
                    RoundedPieSection(fraction: xFraction, totalAngle: fillAngle)
                        .rotation(rotation(for: xFraction, index: 0))
                        .fill(RadialGradient(gradient: .lightRed, center: .center, startRadius: 0, endRadius: 1))
                        .frame(width: geometry.size.width * frameProportion(for: x),
                               height: geometry.size.height * frameProportion(for: x))
                }
                //                    .fill(LinearGradient(gradient: Gradient.red, startPoint: .bottom, endPoint: .top))
                
                if stroke {
                    RoundedPieSection(fraction: yFraction, totalAngle: fillAngle)
                        .rotation(rotation(for: yFraction, index: 1))
                        .stroke(Color.yellow)
                        .frame(width: geometry.size.width * frameProportion(for: y),
                               height: geometry.size.height * frameProportion(for: y))
                } else {
                    RoundedPieSection(fraction: yFraction, totalAngle: fillAngle)
                        .rotation(rotation(for: yFraction, index: 1))
                        .fill(LinearGradient(gradient: .yellow, startPoint: .bottom, endPoint: .top))
                        .frame(width: geometry.size.width * frameProportion(for: y),
                               height: geometry.size.height * frameProportion(for: y))
                }
                
                if stroke {
                    RoundedPieSection(fraction: zFraction, totalAngle: fillAngle)
                        .rotation(rotation(for: zFraction, index: 2))
                        .stroke(Color.blue)
                        .frame(width: geometry.size.width * frameProportion(for: z),
                               height: geometry.size.height * frameProportion(for: z))
                } else {
                    RoundedPieSection(fraction: zFraction, totalAngle: fillAngle)
                        .rotation(rotation(for: zFraction, index: 2))
                        .fill(LinearGradient(gradient: .blue, startPoint: .bottom, endPoint: .top))
                        .frame(width: geometry.size.width * frameProportion(for: z),
                               height: geometry.size.height * frameProportion(for: z))
                }
            }
        })
    }
}

struct RadialGraph_Previews: PreviewProvider {
    static var previews: some View {
        RadialGraph(x: 40, y: 30, z: 50, stroke: false)
            .frame(width: 350, height: 350)
    }
}
