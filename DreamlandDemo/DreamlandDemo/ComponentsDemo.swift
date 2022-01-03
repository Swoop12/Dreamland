//
//  ComponentsDemo.swift
//  DreamlandDemo
//
//  Created by Trevor Adcock on 1/3/22.
//

import SwiftUI
import Dreamland

struct ComponentsDemo: View {
    var body: some View {
        List {
            NavigationLink("Header", destination: { Header(text: "This is a header", accessory: Text("Accessory"))})
        }
    }
}

struct ComponentsDemo_Previews: PreviewProvider {
    static var previews: some View {
        ComponentsDemo()
    }
}
