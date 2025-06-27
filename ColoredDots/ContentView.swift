//
//  ContentView.swift
//  ColoredDots
//
//  Created by Kuti Gbolahan on 27/06/2025.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var points: [SIMD3<Float>] = []

    var body: some View {
        VStack {
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)

            Text("Hello, world!")

            ToggleImmersiveSpaceButton()
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
