//
//  ListView.swift
//  good-wave
//
//  Created by Alejandra ADEIKALAM  on 28/04/2025.
//
import SwiftUI

struct ContentView: View {
    let spot: SurfSpot

    var body: some View {
        ZStack(alignment: .top) {
            MapView()
                .ignoresSafeArea(edges: .top)
                .frame(height: 210)

            VStack {
                HStack {
                    BackButton {
                        // action de retour
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()

            VStack {
                Spacer()
                CircleImage(url: URL(string: spot.imageName))
                    .offset(y: -130)
                    .padding(.bottom, -130)

                VStack(alignment: .leading) {
                    Text(spot.condition)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    HStack {
                        Text(spot.title)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.blue)
                        Spacer()
                        Text(spot.location)
                            .font(.headline)
                    }

                    Divider()

                    Text("About \(spot.title)")
                        .font(.title2)
                        .padding(.bottom, 4)
                        .bold()

                    HStack {
                        Text("Difficulty level")
                            .font(.body)
                        Spacer()
                        HStack(spacing: 2) {
                            ForEach(0..<Int(spot.rating)!, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                        .font(.caption)
                    }
                    .padding(.vertical, 0.5)

                    HStack {
                        Text("Peak surf season")
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
                        }
                    }
                    .font(.caption)
                    .padding(.vertical, 0.5)
                }
                .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView(spot: SurfSpot.example)
}
