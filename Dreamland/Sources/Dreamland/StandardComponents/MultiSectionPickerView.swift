//
//  MultiSectionPicker.swift
//  Taro
//
//  Created by DevMountain on 1/30/21.
//

import SwiftUI

public struct PickerViewModel<T: Hashable, Content: View>: Identifiable {
    public let id: String
    public let title: String
    public let label: String
    public let selection: Binding<T>
    public let content: () -> Content
    
    public init(id: String,
                title: String,
                label: String,
                selection: Binding<T>,
                content: @escaping () -> Content) {
        self.id = id
        self.title = title
        self.label = label
        self.selection = selection
        self.content = content
    }
    
}

public struct MultiSectionPicker<T: Hashable, Content: View>: View {
    
    let models: [PickerViewModel<T, Content>]
    
    public init(models: [PickerViewModel<T, Content>]) {
        self.models = models
    }
    
    public var body: some View {
        GeometryReader { geo in
            HStack(spacing: Spacing.s2) {
                ForEach(models) { model in
                    HStack {
                        Picker(model.title,
                               selection: model.selection,
                               content: model.content)
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: (geo.size.width / CGFloat(models.count)) - (Spacing.s4 / CGFloat(models.count)) - Spacing.s4, height: 150)
                            .clipped()
                        Text(model.label)
                            .font(.title2)
                            .foregroundColor(.secondary)
                            .frame(width: Spacing.s4)
                    }
                }
            }
        }
    }
}

struct MultiSectionPicker_Previews: PreviewProvider {
    static var previews: some View {
        let models =  [
            PickerViewModel(id: "123", title: "Feet", label: "Ft", selection: .constant(6), content: {
                ForEach(0..<8, content: { Text("\($0)")})
            }),
            PickerViewModel(id: "234", title: "Inches", label: "In", selection: .constant(2), content: {
                ForEach(0..<13, content: { Text(String($0))})
            })
        ]
        MultiSectionPicker(models: models)
            .padding()
    }
}
