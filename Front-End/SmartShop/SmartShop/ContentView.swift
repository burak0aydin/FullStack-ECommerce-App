//
//  ContentView.swift
//  SmartShop
//
//  Created by Burak Aydın on 19.03.2025.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.authenticationController) private var authenticationController
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
