//
//  ListView.swift
//  good-wave
//
//  Created by Alejandra ADEIKALAM  on 28/04/2025.
//

import SwiftUI

struct ContentView: View {
    let spot: SurfSpot
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header with map and image
                ZStack(alignment: .bottom) {
                    MapView()
                        .frame(height: 250)
                        .ignoresSafeArea(edges: .top)
                    
                    CircleImage(url: URL(string: spot.photoURL))
                        .frame(width: 120, height: 120)
                        .offset(y: 60)
                        .shadow(radius: 7)
                }
                
                // Main content
                VStack(spacing: 24) {
                    // Header with name and location
                    VStack(spacing: 8) {
                        Text(spot.destination)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text(spot.country)
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(spot.surfBreak.joined(separator: " • "))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                    }
                    .padding(.top, 70)
                    
                    // Main information section
                    VStack(spacing: 20) {
                        // Difficulty
                        InfoCard(
                            title: "Difficulty Level",
                            icon: "crown.fill",
                            content: {
                                HStack(spacing: 4) {
                                    ForEach(0..<spot.difficultyLevel, id: \.self) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.red.opacity(0.7))
                                    }
                                }
                            }
                        )
                        
                        // Season
                        InfoCard(
                            title: "Peak Season",
                            icon: "figure.surfing",
                            content: {
                                Text("\(spot.formattedPeakSeasonBegins) - \(spot.formattedPeakSeasonEnds)")
                                    .foregroundColor(.primary)
                            }
                        )
                        
                        // Forecast link
                        if let url = URL(string: spot.forecastURL ?? "") {
                            Link(destination: url) {
                                HStack {
                                    Image(systemName: "arrow.up.right.circle.fill")
                                    Text("View Forecast")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(12)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .background(Color(.systemBackground))
                .padding(.bottom, 90)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

// Reusable component for info cards
struct InfoCard<Content: View>: View {
    let title: String
    let icon: String
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title, systemImage: icon)
                .font(.headline)
                .foregroundColor(.primary)
            
            content()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

