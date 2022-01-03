//
//  SquareIconButton.swift
//  Taro
//
//  Created by DevMountain on 4/29/21.
//

import SwiftUI


public struct SquareIconButton: View {
    
    public enum Style {
        case fill
        case outline
    }
    
    let image: Image
    let color: Color
    let style: Style
    
    public init(image: Image, color: Color, style: SquareIconButton.Style) {
        self.image = image
        self.color = color
        self.style = style
    }
    
    public var body: some View {
        image
            .foregroundColor(foregroundColor)
            .frame(width: Spacing.s8, height: Spacing.s8)
            .background(backgroundColor)
            .border(style == .outline ? color : Color.clear,
                    width: 2)
            .cornerRadius(4)
    }
    
    private var foregroundColor: Color {
        switch style {
        case .fill:
            return .white
        case .outline:
            return color
        }
    }
    
    private var backgroundColor: Color {
        switch style {
        case .fill:
            return color
        case .outline:
            return Color(.systemBackground)
        }
    }
    
    public static let delete = SquareIconButton(image: Image(systemName: "trash.fill"), color: .red, style: .fill)
    public static let favorite = SquareIconButton(image: Image(systemName: "heart.fill"), color: .blueLight, style: .outline)
    public static let unfavorite = SquareIconButton(image: Image(systemName: "heart.fill"), color: .blueLight, style: .fill)
    public static let trackItem = SquareIconButton(image: Image(systemName: "checkmark.circle.fill"), color: .yellowPrimary, style: .fill)
}

struct SquareIconButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: Spacing.s2) {
            SquareIconButton.delete
            SquareIconButton.favorite
            SquareIconButton.unfavorite
            SquareIconButton.trackItem
        }
    }
}
