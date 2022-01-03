//
//  File.swift
//  
//
//  Created by DevMountain on 1/9/21.
//

import SwiftUI

public extension AnyTransition {
    
    static var slideFade: AnyTransition {
        return AnyTransition.slide
            .combined(with: .opacity)
    }
    
    static var fadeUpFromBottom: AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom).combined(with: .opacity)
        let removal = AnyTransition.move(edge: .bottom).combined(with: .opacity)
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }
    
    static func move(from: Edge, to: Edge) -> AnyTransition {
        let insertion = AnyTransition.move(edge: from)
        let removal = AnyTransition.move(edge: to)
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }
}

