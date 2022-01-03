//
//  LabelModifier.swift
//  Taro
//
//  Created by DevMountain on 1/30/21.
//

import SwiftUI

struct LabelModifier: ViewModifier {
    
    let title: String
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading,
               spacing: Spacing.s1,
               content: {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            content
        })
    }
}

public extension View {
    
    func labeled(_ title: String) -> some View {
        return self.modifier(LabelModifier(title: title))
    }
}

struct LabelModifier_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Form {
                Text("The Answer")
                    .labeled("The Question")
                
                TextField("Hello There", text: .constant("Hello World"))
                    .labeled("Header")
                
                Picker("Woot", selection: .constant(4)) {
                    ForEach(1..<10) {
                        Text(String($0))
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .labeled("Age")
            }
        }
    }
}
