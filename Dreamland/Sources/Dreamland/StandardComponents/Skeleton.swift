//
//  Skeleton.swift
//  Taro
//
//  Created by DevMountain on 12/20/20.
//

import SwiftUI

public struct Skeleton: View {
    
    public init() {}
    
   public var body: some View {
        VStack {
            CardShimmerView()
                .frame(height: 200)
                .padding()
            
            CardShimmerView()
                .frame(height: 50)
                .padding(.horizontal)
            
            HStack {
                CardShimmerView()
                    .frame(width: 75)
                VStack {
                    CardShimmerView()
                    CardShimmerView()
                }
            }
            .frame(height: 80)
            .padding()
            
            HStack {
                CardShimmerView()
                    .frame(width: 75)
                VStack {
                    CardShimmerView()
                    CardShimmerView()
                }
            }
            .frame(height: 80)
            .padding()
            
            HStack {
                CardShimmerView()
                    .frame(width: 75)
                VStack {
                    CardShimmerView()
                    CardShimmerView()
                }
            }
            .frame(height: 80)
            .padding(.horizontal)
        }
    }
}

struct Skeleton_Previews: PreviewProvider {
    static var previews: some View {
        Skeleton()
    }
}
