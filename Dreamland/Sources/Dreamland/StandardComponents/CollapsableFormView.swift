//
//  CollapsablePicker.swift
//  Taro
//
//  Created by DevMountain on 1/30/21.
//

import SwiftUI

public struct CollapsableFormView<Content: View>: View {
    
    @Binding private var open: Bool
    let title: String
    let content: Content
    let selection: String?
    
    public init(title: String,
                open: Binding<Bool>,
                selection: String?,
                @ViewBuilder content: () -> Content) {
        self.title = title
        self._open = open
        self.selection = selection
        self.content = content()
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text(title)
                Spacer()
                if let selection = selection {
                    Text(selection)
                        .foregroundColor(.secondary)
                }
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .rotationEffect(open ? .degrees(90) : .degrees(0))
                    .accessibility(hidden: true)
            }
            .animation(.none)
            if open {
                content
            }
        }
        .onTapGesture {
            withAnimation(Animation.default, { self.open.toggle() })
        }
    }
}

struct CollapsablePicker_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
    
    private struct PreviewView: View {
        
        @State private var showing1 = true
        @State private var showing2 = true
        
        var body: some View {
            Form {
                CollapsableFormView(title: "Text", open: $showing1, selection: nil) {
                    Text("Hi I'm Text View")
                }
                
                CollapsableFormView(title: "Picker", open: $showing2, selection: ForceChoices.jedi.label) {
                    EnumPicker(label: "Force",
                               enumeration: ForceChoices.self,
                               selection: .constant(.jedi))
                        .pickerStyle(WheelPickerStyle())
                }
            }
        }
    }
}
