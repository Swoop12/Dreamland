//
//  Header.swift
//  Taro
//
//  Created by DevMountain on 12/14/20.
//

import SwiftUI

public struct Header<Content: View>: View {
    
    let text: String
    let accessory: Content
    
    public init(text: String,
         @ViewBuilder accessory: (() -> Content)) {
        self.text = text
        self.accessory = accessory()
    }
    
    public init(text: String,
         accessory: Content) {
        self.text = text
        self.accessory = accessory
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline) {
                Text(text)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.secondary)
                Spacer()
                accessory
            }
            Divider()
        }
        .accessibility(addTraits: .isHeader)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                Header(text: "Today") {
                    Button("See All") {
                        print("See All")
                    }
                }
                Header(text: "Tomorrow") {
                    NavigationLink(destination: Text("Woot")) {
                        Button("See All") {
                            print("See All")
                        }
                    }
                    
                }
            }
        }
    }
}
