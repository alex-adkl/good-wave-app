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
                        CircleImage(url: URL(string: spot.photoURL))
                            .offset(y: -100)
                            .padding(.bottom, -100)
                            .zIndex(2)
                        
                        VStack(alignment: .leading) {
                            HStack(alignment: .firstTextBaseline) {
                                Text(spot.destination)
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.blue)
                                
                                Spacer()
                                
                                Text(spot.location)
                                    .font(.headline)
                            }
                            
                            Text(spot.surfBreak.joined(separator: ", "))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .padding(.bottom, 12)

                            Divider()

                            Text("About \(spot.destination)")
                                .font(.title2)
                                .padding(.top, 12)
                                .padding(.bottom, 4)
                                .bold()

                            HStack {
                                Label("Difficulty level", systemImage: "crown.fill")
                                    .font(.body)
                                
                                Spacer()
                                HStack(spacing: 2) {
                                    ForEach(0..<spot.difficultyLevel, id: \.self) { _ in
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
                                Text("\(spot.formattedPeakSeasonBegins) - \(spot.formattedPeakSeasonEnds)")
                                    .font(.body)
                            }
                            .padding(.vertical, 0.5)

                            
                            .padding(.vertical, 0.5)
                            
                            if let url = URL(string: spot.forecastURL ?? "") {
                                HStack {
                                    Link(destination: url) {
                                        Label("See surf forecast", systemImage: "arrow.up.right.circle")
                                            .foregroundColor(.blue)
                                            .font(.body)
                                            .padding(.vertical, 10)
                                    }
                                }
                                .padding(.vertical, 0.5)
                            }
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
    let json = """
    {
        "id": "1",
        "photo": "https://example.com/image.jpg",
        "destination": "The Bubble",
        "country": "Fuerteventura, Canary Islands",
        "season_start": "2024-07-22",
        "season_end": "2024-08-31",
        "surf_break": ["Reef", "Point Break"],
        "difficulty": 4,
        "address": "Calle del Mar, 123",
        "link": "https://www.surfline.com/surf-report/pipeline/..."
    }
    """.data(using: .utf8)!
    let spot = try! JSONDecoder().decode(SurfSpot.self, from: json)
    return ContentView(spot: spot)
}
