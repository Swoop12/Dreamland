//
//  Colors.swift
//  Taro
//
//  Created by DevMountain on 11/28/20.
//

import SwiftUI

public extension Color {
    
    // MARK: - Red
    static let redPrimary = Color.init("RedPrimary", bundle: .dreamland)
    static let redLight = Color("RedLight", bundle: .dreamland)
    static let redDark = Color("RedDark", bundle: .dreamland)
    
    // MARK: - Blue
    static let bluePrimary = Color("BluePrimary", bundle: .dreamland)
    static let blueLight = Color("BlueLight", bundle: .dreamland)
    static let blueDark = Color("BlueDark", bundle: .dreamland)
    
    // MARK: - Yellow
    static let yellowPrimary = Color("YellowPrimary", bundle: .dreamland)
    static let yellowLight = Color("YellowLight", bundle: .dreamland)
    static let yellowDark = Color("YellowDark", bundle: .dreamland)
    
    // MARK: - Green
    static let greenPrimary = Color("GreenPrimary", bundle: .dreamland)
    static let greenLight = Color("GreenLight", bundle: .dreamland)
    static let greenDark = Color("GreenDark", bundle: .dreamland)
    
    // MARK: - Purple
    static let purplePrimary = Color("PurplePrimary", bundle: .dreamland)
    static let purpleLight = Color("PurpleLight")
    static let purpleDark = Color("PurpleDark", bundle: .dreamland)
    
    // MARK: - Text
    static let tertiary = Color(.tertiaryLabel)
    
    static let grayScaleSet: [Color] = [
        Color(.tertiaryLabel),
        Color(.secondaryLabel),
        Color(.quaternaryLabel)
    ]
    
    static let primaryLightSet: [Color] = [
        .redLight,
        .blueLight,
        .yellowLight
    ]
}


struct ColorDemo_Previews: PreviewProvider {
    
    struct ColorViewModel {
        let name: String
        let color: Color
    }
    
    static var previews: some View {
        
        let customColors: [ColorViewModel] = [
            ColorViewModel(name: "Red Primary", color: .redPrimary),
            ColorViewModel(name: "Red Light", color: .redLight),
            ColorViewModel(name: "Red Dark", color: .redDark),
            ColorViewModel(name: "Blue Primary", color: .bluePrimary),
            ColorViewModel(name: "Blue Light", color: .blueLight),
            ColorViewModel(name: "Blue Dark", color: .blueDark),
            ColorViewModel(name: "Yellow Primary", color: .yellowPrimary),
            ColorViewModel(name: "Yellow Light", color: .yellowLight),
            ColorViewModel(name: "Yellow Dark", color: .yellowDark),
            ColorViewModel(name: "Green Primary", color: .greenPrimary),
            ColorViewModel(name: "Green Light", color: .greenLight),
            ColorViewModel(name: "Green Dark", color: .greenDark),
            ColorViewModel(name: "Purple Primary", color: .purplePrimary),
            ColorViewModel(name: "Purple Light", color: .purpleLight),
            ColorViewModel(name: "Purple Dark", color: .purpleDark)
        ]
        
        let systemColors: [ColorViewModel] = [
            ColorViewModel(name: "System Background", color: Color(.systemBackground)),
            ColorViewModel(name: "System Grouped Background", color: Color(.systemGroupedBackground)),
            ColorViewModel(name: "gray", color: .gray)
        ]
        
        Group {
            VStack {
                Header(text: "Custom", accessory: EmptyView())
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], content: {
                    ForEach(customColors, id: \.name) { viewModel in
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
                                .fill(viewModel.color)
                        )
                        
                    }
                })
            }
            .padding()
            VStack {
                Header(text: "System Colors", accessory: EmptyView())
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], content: {
                    ForEach(systemColors, id: \.name) { viewModel in
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
                                .fill(viewModel.color)
                        )
                        
                    }
                })
            }
            .padding()
        }
    }
}
