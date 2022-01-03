//
//  Card.swift
//  Taro
//
//  Created by DevMountain on 4/11/21.
//

import SwiftUI

struct Card: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(.standardCornerRadius)
            .shadow(radius: .standardShadowRadius)
    }
}

public extension View {
    
    func card() -> some View {
        self.modifier(Card())
    }
}

struct Card_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            
            PreviewHost {
                VStack {
                    Text("Card")
                        .padding()
                        .card()
                    
                    VStack {
                        Image(systemName: "star")
                        Text("Card Preview")
                        Image(systemName: "clock")
                    }
                    .padding()
                    .card()
                    
                }
            }
        }
    }
}
