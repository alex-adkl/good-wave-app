//
//  SpotTypeSelector.swift
//  good-wave
//
//  Created by Théo  on 29/04/2025.
//
import SwiftUI

struct SpotTypeSelector: View {
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "fish.fill")
                Text("Reef Break")
            }
            .foregroundColor(.black)

            Spacer()

            VStack {
                Image(systemName: "figure.walk")
                Text("Beach Break")
            }
            .foregroundColor(.gray)

            Spacer()

            VStack {
                Image(systemName: "triangle")
                Text("Point Break")
            }
            .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SpotTypeSelector()
}
