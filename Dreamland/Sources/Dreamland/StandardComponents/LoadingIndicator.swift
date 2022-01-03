//
//  LoadingIndicator.swift
//  Taro
//
//  Created by DevMountain on 12/7/20.
//

import SwiftUI

public struct LoadingIndicator: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            ProgressView()
            Text("Loading...")
        }
        .foregroundColor(.secondary)
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
    }
}
