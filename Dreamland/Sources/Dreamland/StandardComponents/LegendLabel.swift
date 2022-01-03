//
//  LegendLabel.swift
//  Taro
//
//  Created by DevMountain on 12/13/20.
//

import SwiftUI

public struct LegendLabel: View {
        
    let title: String
    
    public init(title: String) {
        self.title = title
    }
    
    public var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: Spacing.s0_5) {
            RoundedRectangle(cornerRadius: 4)
                
                .frame(width: 12, height: 12)
            Text(title)
                .font(.footnote)
                .textCase(.uppercase)
                .lineLimit(1)
                .layoutPriority(1)
        }
    }
}

struct LegendLabel_Previews: PreviewProvider {
    static var previews: some View {
        LegendLabel(title: "Protien")
            .foregroundColor(.redLight)
    }
}
