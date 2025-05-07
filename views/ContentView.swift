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
        ZStack(alignment: .top) {
            MapView()
                .frame(height: 300)
                .ignoresSafeArea(edges: .top)
                .zIndex(0) //MapView en arriere-plan
            
            ScrollView {
                VStack(spacing: 0) {
                    Color.clear
                        .frame(height: 210)
                    
                    VStack {
                        CircleImage(url: URL(string: spot.imageName))
                            .offset(y: -100)
                            .padding(.bottom, -100)
                            .zIndex(2)
                        
                        VStack(alignment: .leading) {
                            HStack(alignment: .firstTextBaseline) {
                                Text(spot.title)
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.blue)
                                
                                Spacer()
                                
                                Text(spot.location)
                                    .font(.headline)
                            }
                            
                            Text(spot.condition)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .padding(.bottom, 12)

                            Divider()

                            Text("About \(spot.title)")
                                .font(.title2)
                                .padding(.top, 12)
                                .padding(.bottom, 4)
                                .bold()

                            HStack {
                                Label("Difficulty level", systemImage: "crown.fill")
                                    .font(.body)
                                
                                Spacer()
                                HStack(spacing: 2) {
                                    ForEach(0..<spot.rating, id: \.self) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.red.opacity(0.8))
                                            .font(.system(size: 15))
                                    }
                                }
                                .font(.caption)
                            }
                            .padding(.vertical, 0.5)

                            HStack {
                                Label("Peak surf season", systemImage: "figure.surfing")
                                    .font(.body)
                                Spacer()
                                Text(spot.dateRange)
                                    .font(.body)
                            }
                            .padding(.vertical, 0.5)

                            HStack {
                                Link(destination: URL(string: spot.forecastURL)!) {
                                    Label("See surf forecast", systemImage: "arrow.up.right.circle")
                                        .foregroundColor(.blue)
                                        .font(.body)
                                        .padding(.vertical, 20)
                                }
                            }
                            .font(.caption)
                            .padding(.vertical, 0.5)
                        }
                        .padding()
                    }
                    .background(Color.white)
                }
            }
        }
    }
}

#Preview {
    ContentView(spot: SurfSpot.example)
}
