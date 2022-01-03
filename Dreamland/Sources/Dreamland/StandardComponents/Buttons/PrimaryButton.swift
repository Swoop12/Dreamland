//
//  CTAButton.swift
//  Taro
//
//  Created by DevMountain on 12/14/20.
//

import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    
    // MARK: - Size
    /// An Enum representing the possible sizes of the button style
    public enum Size {
        case small
        case large
    }
    
    /// The size of teh button
    let size: Size
    
    public init(size: Size) {
        self.size = size
    }
    
    private var padding: CGFloat {
        switch size {
        case .small:
            return 8
        case .large:
            return 16
        }
    }
    
    private let cornerRadius: CGFloat = 4
 
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(padding)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.blueLight)
                    .shadow(radius: 4)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring())
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHost {
            VStack {
                Button("Small Primary Button") {
                    print("Yeet")
                }
                .buttonStyle(PrimaryButtonStyle(size: .small))
                
                Button {
                    print("Woot")
                } label: {
                    HStack {
                        Image(systemName: "circle.fill")
                        Text("Large Primary Button")
                    }
                }
                .buttonStyle(PrimaryButtonStyle(size: .large))
                
            }
            .padding()
        }
    }
}
