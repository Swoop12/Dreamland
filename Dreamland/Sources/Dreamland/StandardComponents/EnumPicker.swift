//
//  EnumPicker.swift
//  Taro
//
//  Created by DevMountain on 1/30/21.
//

import SwiftUI

public protocol Labelable {
    var label: String { get }
}

public typealias LabelableCaseIterableEnum = CaseIterable & Hashable & Labelable & RawRepresentable & Identifiable

public struct EnumPicker<Enumation: LabelableCaseIterableEnum>: View {
    
    let label: String
    let choices: [Enumation]
    @Binding var selection: Enumation
    
    public init(label: String,
         enumeration: Enumation.Type,
         selection: Binding<Enumation>) {
        self.label = label
        self.choices = enumeration.allCases.map { $0 }
        self._selection = selection
    }
    
    public var body: some View {
        Picker(selection: $selection,
               label: Text(label)
               , content: {
                ForEach(choices) { enumCase in
                    Text(enumCase.label)
                        .tag(enumCase)
                }
               })
    }
}

enum ForceChoices: String, CaseIterable, Labelable, Identifiable {
    case jedi
    case sith
    case gray
    
    var label: String {
        return rawValue.capitalized
    }
    
    var id: String {
        rawValue
    }
}

struct EnumPicker_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewView()
            
            PreviewView()
                .previewDevice("iPad Pro (11-inch) (2nd generation)")
        }
    }
    
    private struct PreviewView: View {
        
        @State private var selection: ForceChoices = .jedi
        
        var body: some View {
            NavigationView {
                Form {
                    EnumPicker.init(label: "Force Sensitive", enumeration: ForceChoices.self, selection: $selection)
                    
                    EnumPicker.init(label: "Force Sensitive", enumeration: ForceChoices.self, selection: $selection)
                        .pickerStyle(InlinePickerStyle())
                    
                    EnumPicker.init(label: "Force Sensitive", enumeration: ForceChoices.self, selection: $selection)
                        .pickerStyle(WheelPickerStyle())
                    
                    EnumPicker.init(label: "Force Sensitive", enumeration: ForceChoices.self, selection: $selection)
                        .pickerStyle(MenuPickerStyle())
                }
            }
        }
    }
}
