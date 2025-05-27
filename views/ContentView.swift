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
                // ZStack pour overlay boutons sur la photo
                ZStack(alignment: .top) {
                    // Photo du spot en rectangle
                    if let url = URL(string: spot.photoURL) {
                        AsyncImageView(url: url, placeholder: "photo")
                            .frame(height: 250)
                    }
                    // Boutons overlay
                    HStack {
                        // Bouton retour
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white.opacity(0.6))
                                .clipShape(Circle())
                        }
                        Spacer()
                        // Bouton partage
                        Button(action: {
                            // Action de partage à compléter
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white.opacity(0.6))
                                .clipShape(Circle())
                        }
                        // Bouton favori
                        Button(action: {
                            // Action favori à compléter
                        }) {
                            Image(systemName: "heart")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white.opacity(0.6))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 15)
                    // Barre blanche épaisse, toute largeur, au niveau du cercle avec la carte
                    VStack {
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .fill(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .padding(.horizontal, 0)
                            .padding(.top, 250 - 12) // 250 = hauteur de la photo, 12 = moitié de la hauteur de la barre
                        Spacer()
                    }
                }
                .ignoresSafeArea(.all, edges: .top)
                // Cercle par-dessus : carte
                ZStack(alignment: .bottom) {
                    Color.clear.frame(height: 0) // pour garder la structure du ZStack
                    MapView()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.clear, lineWidth: 1)
                        )
                        .offset(y: 60)
                        .shadow(radius: 7)
                }
                VStack(spacing: 24) {
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
                    VStack(spacing: 20) {
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
                        InfoCard(
                            title: "Peak Season",
                            icon: "figure.surfing",
                            content: {
                                Text("\(spot.formattedPeakSeasonBegins) - \(spot.formattedPeakSeasonEnds)")
                                    .foregroundColor(.primary)
                            }
                        )
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
                .padding(.bottom, 90)
            }
        }
        .background(Color.clear)
        .ignoresSafeArea(.all, edges: .top)
        .navigationBarHidden(true)
    }
}

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

