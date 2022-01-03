//
//  PieChart.swift
//  Taro
//
//  Created by DevMountain on 12/13/20.
//

import SwiftUI

public struct PieChart: View {
    
    public let totalAngle: Double
    public let sections: [Double]
    
    public var colors: [Color] = [
        .redLight,
        .blueLight,
        .yellowLight
    ]
    
    public var total: Double {
        return sections.reduce(0) { $0 + $1 }
    }
    
    public var max: Double {
        return sections.max()!
    }
    
    public init(
        totalAngle: Double,
        sections: [Double],
        colors: [Color] = [.redLight,
                           .blueLight,
                           .yellowLight]
    ) {
        self.totalAngle = totalAngle
        self.sections = sections
        self.colors = colors
    }
    
    public var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                ForEach(0..<sections.count) { index in
                    SharpPieSection(fraction: sections[index]/total, totalAngle: totalAngle)
                        .fill(
                            color(for: index)
                        )
                        .rotationEffect(rotation(for: index))
                        .frame(width: size(for: index, geometry: geometry),
                               height: size(for: index, geometry: geometry))
                }
            }
            .rotationEffect(.degrees(-90))
        })
        .accessibilityElement(children: .combine)
    }
    
    static var placeholder: some View {
        PieChart(totalAngle: 360,
                 sections: [1,1.1,1.2],
                 colors: [
                    Color(.secondarySystemFill),
                    Color(.tertiarySystemFill),
                    Color(.quaternarySystemFill)
                 ])
            .redacted(reason: .placeholder)
    }
    
    private func color(for index: Int) -> Color {
        if index < colors.count {
            return colors[index]
        } else {
            let scaledIndex = index % colors.count
            return colors[scaledIndex]
        }
    }
    
    private func rotation(for index: Int) -> Angle {
        guard index > 0 else { return .zero }
        let slice = sections[0..<index]
        let fraction = slice.reduce(Double(0)) { result, next in
            result + (next / total)
        }
        return .degrees(totalAngle * fraction)
    }
    
    private func size(for index: Int, geometry: GeometryProxy) -> CGFloat {
        let section = sections[index]
        let perecentOfMax = section / max
        let s = Swift.min(geometry.size.width, geometry.size.height)
        let proportionalPadding = CGFloat(1 - perecentOfMax) * s * 0.3
        let size = Swift.max(0,Double(s - proportionalPadding))
        return CGFloat(size)
    }
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(totalAngle: 360, sections: [0.2, 0.3, 0.6])
            .frame(width: 200, height: 200)
    }
}

