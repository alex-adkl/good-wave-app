//
//  SearchBar.swift
//  good-wave
//
//  Created by Théo  on 29/04/2025.
//
import SwiftUI

struct SearchBar: View {
    var body: some View {
        HStack(spacing: 8) {
            Text("Research a spot")
                .foregroundColor(.black)
            Image(systemName: "magnifyingglass")
            
        }
        .frame(maxWidth: .infinity)
        .multilineTextAlignment(.center)
        .frame(maxWidth: 280, alignment: .center)
        .padding()
        .background(Color(.white))
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .cornerRadius(25)
        .shadow(color: Color(.systemGray3).opacity(0.4), radius: 6, x: 0, y: 2)
        
    }
}

#Preview {
    SearchBar()
}
