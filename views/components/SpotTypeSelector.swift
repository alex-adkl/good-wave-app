//
//  SpotTypeSelector.swift
//  good-wave
//
//  Created by Théo  on 29/04/2025.
//
import SwiftUI

struct SpotTypeSelector: View {
    @Binding var selectedType: String?
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 40) {
                VStack {
                    Image(systemName: "fish")
                    Text("Reef Break")
                        .padding(.bottom)
                        .overlay(
                            Rectangle()
                                .frame(height: 3)
                                    .foregroundColor(selectedType == "Reef Break" ? .black : .clear)
                                .padding(.top,3),
                            alignment: .bottom
                        )
                }
                .padding(.leading, 14)
                .foregroundColor(selectedType == "Reef Break" ? .black : .gray)
                .onTapGesture {
                    selectedType = selectedType == "Reef Break" ? nil : "Reef Break"
                }

                VStack {
                    Image(systemName: "beach.umbrella")
                    Text("Beach Break")
                        .padding(.bottom)
                            .overlay(
                                Rectangle()
                                    .frame(height: 3)
                                    .foregroundColor(selectedType == "Beach Break" ? .black : .clear)
                                    .padding(.top,3),
                                alignment: .bottom
                            )
                }
                    .foregroundColor(selectedType == "Beach Break" ? .black : .gray)
                    .onTapGesture {
                        selectedType = selectedType == "Beach Break" ? nil : "Beach Break"
                    }

                VStack {
                    Image(systemName: "button.angledtop.vertical.left")
                    Text("Point Break")
                        .padding(.bottom)
                            .overlay(
                                Rectangle()
                                    .frame(height: 3)
                                    .foregroundColor(selectedType == "Point Break" ? .black : .clear)
                                    .padding(.top,3),
                                alignment: .bottom
                            )
                }
                    .foregroundColor(selectedType == "Point Break" ? .black : .gray)
                    .onTapGesture {
                        selectedType = selectedType == "Point Break" ? nil : "Point Break"
                    }
                    
                    VStack {
                        Image(systemName: "water.waves")
                        Text("Outer Banks")
                            .padding(.bottom)
                            .overlay(
                                Rectangle()
                                    .frame(height: 3)
                                    .foregroundColor(selectedType == "Outer Banks" ? .black : .clear)
                                    .padding(.top,3),
                                alignment: .bottom
                            )
                    }
                    .foregroundColor(selectedType == "Outer Banks" ? .black : .gray)
                    .onTapGesture {
                        selectedType = selectedType == "Outer Banks" ? nil : "Outer Banks"
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    SpotTypeSelector(selectedType: .constant(nil))
}
