//
//  SwipeableView.swift
//  Taro
//
//  Created by DevMountain on 4/27/21.
//

import SwiftUI
 
public struct SwipeableView<Content: View, HiddenView: View>: View {
    
    @State private var dragXOffset: CGFloat = 0
    @State private var hiddenContentSize: CGSize = .zero
    @State private var hapticFired: Bool = false
    @State private var dragStartPoint: CGFloat = 0
    
    let content: Content
    let hiddenView: HiddenView
    
    private let lockInBreakPoint: CGFloat = 0.5
    
    public init(@ViewBuilder content: () -> Content,
         @ViewBuilder hiddenView: () -> HiddenView) {
        self.content = content()
        self.hiddenView = hiddenView()
    }
    
    public init(content: Content, hiddenView: HiddenView) {
        self.content = content
        self.hiddenView = hiddenView
    }
    
    private var hiddenViewScaleEffect: CGFloat {
        guard dragXOffset < 0,
              hiddenContentSize.width > 0 else { return 1 }
        return max(-dragXOffset/hiddenContentSize.width, 1)
    }
    
    public var body: some View {
        ZStack(alignment: .trailing) {
            hiddenView
                .readSize { self.hiddenContentSize = $0 }
                .opacity(Double(-dragXOffset)/Double(hiddenContentSize.width))
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground))
                .gesture(
                    DragGesture()
                        .onChanged(onDragChange(_:))
                        .onEnded(onDragEnded(_:))
                    
                )
                .offset(x: dragXOffset)
                .animation(.spring())
        }
        .animation(.easeInOut)
    }
    
    private func onDragChange(_ value: DragGesture.Value) {
        let xTranslation = value.translation.width
        self.dragXOffset = xTranslation + dragStartPoint
        if -xTranslation >= (hiddenContentSize.width * lockInBreakPoint),
           !hapticFired {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            hapticFired = true
        } else if -xTranslation < (hiddenContentSize.width * lockInBreakPoint),
                  hapticFired {
            hapticFired = false
        }
    }
    
    private func onDragEnded(_ value: DragGesture.Value) {
        let xTranslation = value.translation.width
        if -xTranslation >= (hiddenContentSize.width * lockInBreakPoint) {
            self.dragXOffset = -hiddenContentSize.width
            self.dragStartPoint = -hiddenContentSize.width
        } else {
            self.dragXOffset = 0
            self.dragStartPoint = 0
        }
    }
}

struct SwipeableView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeableView(
            content: Text("Hello World"),
            hiddenView: Button("Delete",
                               action: {
                                print("Woot")
                               }
            )
        )
    }
}
