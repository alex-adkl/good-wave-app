//
//  SearchBar.swift
//  good-wave
//
//  Created by Théo  on 29/04/2025.
//
import SwiftUI

struct SearchBar: View {
    var body: some View {
        ZStack(alignment: .trailing) {
            // Background bar
            HStack {
                Spacer()
                Text("Research a spot")
                    .foregroundColor(.black)
                Spacer()
            }
            .frame(height: 44)
            .frame(maxWidth: 280)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color(.systemGray5), lineWidth: 1)
            )
            .cornerRadius(25)
            .shadow(color: Color(.systemGray3).opacity(0.4), radius: 6, x: 0, y: 2)

            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 44, height: 44)
                    .overlay(
                        Circle()
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    )
                    .shadow(color: Color(.systemGray3).opacity(0.4), radius: 3, x: 0, y: 1)

                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
            }
            .offset(x: 8)
        }
    }
}

#Preview {
    SearchBar()
}
