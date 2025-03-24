//
//  MyProductListScreen.swift
//  SmartShop
//
//  Created by Burak Aydın on 24.03.2025.
//

import SwiftUI

struct MyProductListScreen: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        Text("My Product List Screen")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Product") {
                        isPresented = true
                    }
                }
            }).sheet(isPresented: $isPresented, content: {
                NavigationStack {
                    AddProductScreen()
                }
            })
    }
}

#Preview {
    NavigationStack {
        MyProductListScreen()
    }
}
