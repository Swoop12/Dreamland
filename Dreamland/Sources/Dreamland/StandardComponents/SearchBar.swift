//
//  SearchBar.swift
//  Taro
//
//  Created by DevMountain on 12/12/20.
//

import SwiftUI

public struct SearchBar: View {
    @Binding var text: String
    let onCommit: (() -> Void)?
    let onEditingChanged: ((Bool) -> Void)?
    
    public init(text: Binding<String>,
                onCommit: (() -> Void)?,
                onEditingChanged: ((Bool) -> Void)?) {
        self._text = text
        self.onCommit = onCommit
        self.onEditingChanged = onEditingChanged
    }
    
    
    
    public var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
                .accessibility(hidden: true)
            
            TextField("Search", text: $text, onEditingChanged: onEditingChanged ?? {_ in }, onCommit: onCommit ?? {})
                .frame(maxWidth: .infinity)
                .accessibility(addTraits: [.isSearchField])
            
            Button(action: {
                self.text = ""
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.secondary)
            })
            .accessibility(label: Text("Clear Search"))
            .accessibility(hint: Text("Removes the current text from the search bar"))
            .accessibility(hidden: text.isEmpty)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.tertiarySystemFill))
        )
        .accessibilityElement(children: .contain)
        .accessibility(value: Text(text))
    }
}

struct SearchBar_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            VStack {
                SearchBar(text: .constant("Search Text"), onCommit: nil, onEditingChanged: nil)
                    .colorScheme(.light)
                    .padding()
                
                SearchBar(text: .constant(""), onCommit: nil, onEditingChanged: nil)
                    .colorScheme(.light)
                    .padding()
                
                Spacer()
            }
            
            VStack {
                SearchBar(text: .constant("Search Text"), onCommit: nil, onEditingChanged: nil)
                    .padding()
                
                SearchBar(text: .constant(""), onCommit: nil, onEditingChanged: nil)
                    .padding()
                
                Spacer()
            }
            .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
            
            .colorScheme(.dark)
            
        }
    }
}
