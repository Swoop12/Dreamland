//
//  EagerVGrid.swift
//  Taro
//
//  Created by DevMountain on 5/13/21.
//

import SwiftUI

public struct EagerVGrid<Content: View, Model>: View {
    
    let models: [Model]
    let columns: Int
    let rowSpacing: CGFloat = Spacing.s1
    let columnSpacing: CGFloat = Spacing.s1
    let content: (Model) -> Content
    
    private var rows: Int {
        guard columns > 0 else { return 0 }
        let fractionalRows = Double(models.count)/Double(columns)
        return Int(ceil(fractionalRows))
    }
    
    public init(models: [Model],
                columns: Int,
                @ViewBuilder content: @escaping (Model) -> Content) {
        self.models = models
        self.columns = columns
        self.content = content
    }
    
    
    public var body: some View {
        VStack(spacing: columnSpacing) {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack(spacing: rowSpacing) {
                    ForEach(0 ..< columns, id: \.self) { column in
                        if let model = model(row: row, col: column) {
                            content(model)
                        } else {
                            if let defaultModel = models.first {
                                content(defaultModel)
                                    .hidden()
                            } else {
                                EmptyView()
                            }
                                
                        }
                    }
                }
            }
        }
    }
    
    private func model(row: Int, col: Int) -> Model? {
        let index = (columns * row) + col
        guard index >= 0,
              index < models.count else { return nil }
        return models[index]
    }
}

struct EagerVGrid_Previews: PreviewProvider {
    static var previews: some View {
        let numbers = Array(0...31)
        EagerVGrid(models: numbers, columns: 7) { number in
            Text(String(number))
                .font(.footnote)
                .frame(maxWidth: .infinity)
                .padding()
                .card()
        }
        .padding()
    }
}
