//
//  SpotTypeSelector.swift
//  good-wave
//
//  Created by Théo  on 29/04/2025.
//
import SwiftUI

struct SpotTypeSelector: View {
    @Binding var selectedType: String?
    // Tableau des types
    let types: [(icon: String, label: String)] = [
        ("fish", "Reef Break"),
        ("beach.umbrella", "Beach Break"),
        ("button.angledtop.vertical.left", "Point Break"),
        ("water.waves", "Outer Banks")
    ]
    // Index courant
    @State private var currentIndex: Int = 0

    var body: some View {
        VStack(spacing: 8) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 40) {
                    ForEach(types.indices, id: \ .self) { index in
                        VStack {
                            Image(systemName: types[index].icon)
                            Text(types[index].label)
                                .padding(.bottom)
                        }
                        .padding(.leading, index == 0 ? 10 : 0)
                        .foregroundColor(selectedType == types[index].label ? .black : .gray)
                        .onTapGesture {
                            selectedType = selectedType == types[index].label ? nil : types[index].label
                            currentIndex = index
                        }
                    }
                }
                .padding(.horizontal)
            }
            // Points d'indication
            HStack(spacing: 8) {
                ForEach(types.indices, id: \ .self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.black : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.top, 2)
        }
    }
}

#Preview {
    SpotTypeSelector(selectedType: .constant(nil))
}
