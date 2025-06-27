//
//  ContentView.swift
//  ColoredDots
//
//  Created by Kuti Gbolahan on 27/06/2025.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @State private var points: [SIMD3<Float>] = []

    var body: some View {
        RealityView { content in
            // Transparent plane to tap on
            let plane = ModelEntity(
                mesh: .generatePlane(width: 1.5, depth: 1.5),
                materials: [SimpleMaterial(color: .clear, isMetallic: false)]
            )
            plane.name = "tap-surface"
            plane.generateCollisionShapes(recursive: true)
            plane.position = [0, 1.4, -1]
            content.add(plane)

            // Add blue dots for each tapped point
            for point in points {
                let dot = ModelEntity(mesh: .generateSphere(radius: 0.015))
                dot.position = point
                dot.model?.materials = [SimpleMaterial(color: .blue, isMetallic: false)]
                content.add(dot)
            }
        } update: { content in
            content.entities.removeAll()

            // Re-add plane
            let plane = ModelEntity(
                mesh: .generatePlane(width: 1.5, depth: 1.5),
                materials: [SimpleMaterial(color: .clear, isMetallic: false)]
            )
            plane.name = "tap-surface"
            plane.generateCollisionShapes(recursive: true)
            plane.position = [0, 1.4, -1]
            content.add(plane)

            // Re-add dots
            for point in points {
                let dot = ModelEntity(mesh: .generateSphere(radius: 0.015))
                dot.position = point
                dot.model?.materials = [SimpleMaterial(color: .blue, isMetallic: false)]
                content.add(dot)
            }
        }
        .gesture(
            TapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    let tappedEntity = value.entity

                    // Confirm it's our invisible plane
                    if tappedEntity.name == "tap-surface" {
                        // Use the exact position where it was tapped
                        let worldPosition = tappedEntity.position(relativeTo: nil)
                        points.append(worldPosition)
                    }
                }
        )
        .overlay(alignment: .bottom) {
            Button("Clear Drawing") {
                points.removeAll()
            }
            .padding()
            .glassBackgroundEffect()
        }
    }
}



#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
