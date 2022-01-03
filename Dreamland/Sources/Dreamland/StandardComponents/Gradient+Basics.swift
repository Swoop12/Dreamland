//
//  Gradient+Basics.swift
//  Taro
//
//  Created by DevMountain on 11/28/20.
//

import SwiftUI

public extension Gradient {
    
    static let red = Gradient(colors: [Color.redPrimary, Color.redPrimary.opacity(0.9)])
    static let lightRed = Gradient(colors: [Color.redPrimary, Color.redLight])
    static let darkRed = Gradient(colors: [Color.redPrimary, Color.redDark])
    
    static let blue = Gradient(colors: [Color.bluePrimary, Color.blueLight])
    static let darkBlue = Gradient(colors: [Color.bluePrimary, Color.blueDark])
    
    static let yellow = Gradient(colors: [Color.yellowPrimary, Color.yellowLight])
    static let darkYellow = Gradient(colors: [Color.yellowPrimary, Color.yellowDark])
    
    static let green = Gradient(colors: [Color.greenPrimary, Color.greenLight])
    static let darkGreen = Gradient(colors: [Color.greenPrimary, Color.greenDark])
    
    static let purple = Gradient(colors: [Color.purplePrimary, Color.purpleLight])
    static let darkPurple = Gradient(colors: [Color.purplePrimary, Color.purpleDark])
    
    static let gray = Gradient(colors: [Color(UIColor.systemGroupedBackground),
                                        Color(UIColor.tertiarySystemGroupedBackground)])
}

struct GradientDemo_Previews: PreviewProvider {
    
    struct GradientViewModel {
        let name: String
        let gradient: Gradient
    }
    
    static var previews: some View {
        
        let gradients: [GradientViewModel] = [
            GradientViewModel(name: "Red Light", gradient: .lightRed),
            GradientViewModel(name: "Red Dark", gradient: .darkRed),
            GradientViewModel(name: "Blue Light", gradient: .blue),
            GradientViewModel(name: "Blue Dark", gradient: .darkBlue),
            GradientViewModel(name: "Yellow Light", gradient: .yellow),
            GradientViewModel(name: "Yellow Dark", gradient: .darkYellow),
            GradientViewModel(name: "Green Light", gradient: .green),
            GradientViewModel(name: "Green Dark", gradient: .darkGreen),
            GradientViewModel(name: "Purple Light", gradient: .purple),
            GradientViewModel(name: "Purple Dark", gradient: .darkPurple),
            GradientViewModel(name: "gray", gradient: .gray),
        ]
        
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], content: {
            ForEach(gradients, id: \.name) { viewModel in
                VStack {
                    Text(viewModel.name)
                        .foregroundColor(.white)
                    
                    Text(viewModel.name)
                        .foregroundColor(.primary)
                }
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LinearGradient(gradient: viewModel.gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                )
                    
            }
        })
        .padding()
    }
}
