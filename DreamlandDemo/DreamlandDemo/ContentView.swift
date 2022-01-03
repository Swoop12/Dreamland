//
//  ContentView.swift
//  DreamlandDemo
//
//  Created by Trevor Adcock on 1/3/22.
//

import SwiftUI
import Dreamland

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Colors", destination: { ColorDemo() })
                NavigationLink("Components", destination: { ComponentsDemo() })
            }
            .navigationTitle("Dreamland")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
