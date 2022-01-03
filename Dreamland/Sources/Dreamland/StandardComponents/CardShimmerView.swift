//
//  CardShimmerView.swift
//  Taro
//
//  Created by DevMountain on 12/13/20.
//

import SwiftUI

public struct CardShimmerView: View {
    
    @State var show = false
    
    let animation = Animation.default
        .speed(0.075)
        .delay(0)
        .repeatForever(autoreverses: false)
    
    var screenSize = UIScreen.main.bounds.width + 50
    
    let shimmerColor = UIColor { traitCollection -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor.white.withAlphaComponent(0.035)
        } else {
            return UIColor.white.withAlphaComponent(0.8)
        }
    }
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(.tertiarySystemFill)
                    .cornerRadius(.standardCornerRadius)
                
                Color.white
                    .cornerRadius(.standardShadowRadius)
                    .mask(
                        Rectangle()
                            .fill(
                                LinearGradient(gradient: .init(colors: [.clear, Color(shimmerColor), .clear]),
                                               startPoint: .top,
                                               endPoint: .bottom)
                            )
                            .frame(width: (geo.size.width * 1.5),
                                   height: (geo.size.height * 1.5))
                            .rotationEffect(.degrees(70))
                            .offset(x: self.show ? screenSize : -screenSize)
                    )
                    .onAppear {
                        withAnimation(animation) {
                            self.show.toggle()
                        }
                    }
            }
        }
    }
}

struct CardShimmerView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color(.systemBackground))
                    .frame(width: 300, height: 300)
                
                CardShimmerView()
                    .frame(width: 200, height: 200)
                    .padding()
            }
            
            ZStack {
                Rectangle()
                    .fill(Color(.systemBackground))
                    .frame(width: 300, height: 300)
                
            CardShimmerView()
                .frame(width: 200, height: 200)
                .padding()
            }
            .colorScheme(.dark)
        }
    }
}
