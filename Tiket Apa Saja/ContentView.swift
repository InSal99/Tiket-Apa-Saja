//
//  ContentView.swift
//  Tiket Apa Saja
//
//  Created by Intan Saliya Utomo on 03/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
    init() {
        for familyName in UIFont.familyNames{
            print (familyName )
            for fontName in UIFont.fontNames(forFamilyName:familyName) {
                print("-- \(fontName)")
            }
        }
    }
}

#Preview {
    ContentView()
}
