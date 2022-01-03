//
//  ColorDemo.swift
//  DreamlandDemo
//
//  Created by Trevor Adcock on 1/3/22.
//

import SwiftUI
import Dreamland

struct ColorDemo: View {
    
    struct ColorViewModel {
        let name: String
        let color: Color
    }
    
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
    
    var body: some View {
        ScrollView {
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
}
