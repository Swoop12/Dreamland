//
//  ReadSize.swift
//  Taro
//
//  Created by DevMountain on 4/29/21.
//

import SwiftUI

public extension View {
    
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        return self
            .background(
                GeometryReader(content: { proxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                })
            )
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
