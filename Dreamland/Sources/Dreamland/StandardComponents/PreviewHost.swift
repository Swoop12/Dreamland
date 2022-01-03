//
//  PreviewHost.swift
//  Taro
//
//  Created by DevMountain on 1/23/21.
//

import SwiftUI


public struct PreviewHost<Content: View>: View {
    
    let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        VStack {
            ZStack {
                Color(.systemBackground)
                content
            }
            .colorScheme(.light)
            
            ZStack {
                Color(.systemBackground)
                content
            }
            .colorScheme(.dark)
        }
    }
}
