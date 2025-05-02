//
//  SpotTypeSelector.swift
//  good-wave
//
//  Created by Théo  on 29/04/2025.
//
import SwiftUI

struct SpotTypeSelector: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Image(systemName: "fish")
                    Text("Reef Break")
                        .padding(.bottom)
                        .overlay(
                            Rectangle()
                                .frame(height: 3)
                                .foregroundColor(.black)
                                .padding(.top,3),
                            alignment: .bottom
                        )
                }
                .foregroundColor(.black)

                Spacer()

                VStack {
                    Image(systemName: "beach.umbrella")
                    Text("Beach Break")
                        .padding(.bottom)
                }
                .foregroundColor(.gray)

                Spacer()

                VStack {
                    Image(systemName: "button.angledtop.vertical.left")
                    Text("Point Break")
                        .padding(.bottom)
                }
                .foregroundColor(.gray)
            }
            .padding(.horizontal)
        }
       
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.1), radius: 7, x: 0, y: 10)
    }
}

#Preview {
    SpotTypeSelector()
}
