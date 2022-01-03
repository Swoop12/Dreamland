//
//  SharpPieSection.swift
//  Taro
//
//  Created by DevMountain on 12/13/20.
//

import SwiftUI

struct SharpPieSection: Shape {
    
    // MARK: - Properties
    let fraction: Double
    let totalAngle: Double
    
    // MARK: - Initializers
    init(fraction: Double, totalAngle: Double = 360) {
        self.fraction = fraction
        self.totalAngle = totalAngle
    }
    
    // MARK: - Shpae
    func path(in rect: CGRect) -> Path {
        let trueCenter = CGPoint(x: rect.midX, y: rect.midY)
        let radius = rect.width/2
        var path = Path()
        path.move(to: trueCenter)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addArc(center: trueCenter,
                         radius: radius,
                         startAngle: .degrees(0),
                         endAngle: .degrees((totalAngle * fraction)),
                         clockwise: false)
        path.addLine(to: trueCenter)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

struct SharpPieSection_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack {
                ForEach(1..<11) { index in
                    SharpPieSection(fraction: Double(index) / 10.0, totalAngle: 360)
                        .frame(width: 100, height: 100)
                }
            }
        }
    }
}
