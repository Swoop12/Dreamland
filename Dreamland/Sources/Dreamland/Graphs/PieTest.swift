//
//  PieTest.swift
//  Taro
//
//  Created by DevMountain on 11/30/20.
//

import SwiftUI

public struct PieTest: View {
    let colors: [Color] = [.blue, .blue, .red, .orange, .yellow, .green, .purple, .blue, .red, .orange, .yellow, .green, .purple]
    
    @State private var frameScale: CGFloat = 0.5
    @State private var count: Int = 3
    @State private var size: Double = 0.25
    
    func rotation(for index: Int) -> Double {
        let rotationIncrement = 360/count
        return Double(rotationIncrement * index)
    }
    
    public init() {}
    
    public var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    ForEach(0...count, id: \.self) { index in
                        RoundedPieSection(fraction: size)
                            .fill(LinearGradient(gradient: Gradient(colors: [colors[index], colors[index + 1]]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .rotationEffect(.degrees(self.rotation(for: index)))
                            .shadow(radius: 2)
                        
                    }
                }
                .frame(width: geo.size.width * frameScale, height: geo.size.width * frameScale)
            
                VStack {
                    HStack {
                        Text("Frame")
                        Slider(value: $frameScale, in: 0...1)
                    }
                    HStack {
                        Text("Count")
                        Stepper("Count", value: $count)
                    }
                    
                    HStack {
                        Text("Size")
                        Slider(value: $size, in: 0...1)
                    }
                }
            }
        }
    }
}

struct PieTest_Previews: PreviewProvider {
    static var previews: some View {
        PieTest()
    }
}
