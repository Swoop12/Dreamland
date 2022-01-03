//
//  If+ViewModifier.swift
//  Taro
//
//  Created by DevMountain on 5/9/21.
//

import SwiftUI

public extension View {
    
    @ViewBuilder
    func `if`<ModifiedView: View>(_ condition: Bool,
                                  modifier: (Self) -> ModifiedView) -> some View {
        if condition {
            modifier(self)
        } else {
            self
        }
    }
}
