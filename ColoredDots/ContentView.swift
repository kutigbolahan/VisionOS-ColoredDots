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
        RealityView{ content in
            for point in points{
                let sphere = ModelEntity(mesh: .generateSphere(radius: 0.01))
                sphere.position = point
                sphere.model?.materials = [SimpleMaterial( color: .blue, isMetallic: false)]
                content.add(sphere)
            }
        } update:{ content in
            content.entities.removeAll()
            for point in points {
                let sphere = ModelEntity(mesh: .generateSphere(radius: 0.01))
                sphere.position = point
                sphere.model?.materials = [SimpleMaterial(
                    color: .blue, isMetallic: false
                )]
                content.add(sphere)
            }
            
        }
        .gesture(
            TapGesture()
                    .targetedToAnyEntity()
                    .onEnded { gesture in
                        let location = gesture.entity.position(relativeTo: nil)
                        points.append(location)
                    }
                )
        
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
