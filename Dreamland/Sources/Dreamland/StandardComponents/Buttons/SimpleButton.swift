//
//  SimpleButton.swift
//  Taro
//
//  Created by DevMountain on 1/23/21.
//

import SwiftUI

public struct SimpleButtonStyle: ButtonStyle {
    
    @Environment(\.colorScheme) var colorScheme
    
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
            return 12
        }
    }
    
    private let cornerRadius: CGFloat = 4
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(foregroundColor)
            .padding(padding)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color(.secondarySystemGroupedBackground))
                    .shadow(color: shadowColor,
                            radius: 4)
            )
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
    }
    
    private var foregroundColor: Color {
        colorScheme == .dark ? .white : .secondary
    }
    
    private var shadowColor: Color {
        colorScheme == .dark ? .clear : .tertiary
    }
}

struct SimpleButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PreviewHost {
                VStack {
                    Button(action: {}, label: {
                        Text("Large Button")
                    })
                    .buttonStyle(SimpleButtonStyle(size: .large))
                    Button(action: {}, label: {
                        Text("Large Button")
                    })
                    .buttonStyle(SimpleButtonStyle(size: .large))
                    Button(action: {}, label: {
                        Text("Large Button")
                    })
                    .buttonStyle(SimpleButtonStyle(size: .large))
                }
                .padding()
            }
            
            PreviewHost {
                Button(action: {}, label: {
                    Text("Small Button")
                })
                .buttonStyle(SimpleButtonStyle(size: .small))
                .padding()
            }
        }
    }
}
