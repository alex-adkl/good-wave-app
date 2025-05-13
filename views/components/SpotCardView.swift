//
//  SpotCardView.swift
//  good-wave
//
//  Created by Théo  on 29/04/2025.
//
import SwiftUI

struct SpotCardView: View {
    let spot: SurfSpot

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                AsyncImageView(url: URL(string: spot.photoURL), placeholder: "figure.surfing")
                    .frame(height: 200)
                    .frame(width: 370)
                    .cornerRadius(16)
                    .clipped()

                Text("Peeps favorite")
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding(10)

                HStack {
                    Spacer()
                    Image(systemName: "heart")
                        .foregroundColor(.black)
                        .padding(8)
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding(10)
                }
            }
            
            HStack(alignment: .firstTextBaseline) {
                Text("\(spot.destination) • \(spot.destinationState)")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Text("★ \(spot.difficultyLevel)")
                    .foregroundColor(.red.opacity(0.7))
            }
            
            HStack {
                Text("\(spot.formattedPeakSeasonBegins) - \(spot.formattedPeakSeasonEnds)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text(spot.surfBreak.joined(separator: ", ").uppercased())
                    .bold()
                    .foregroundColor(.black)
            }
        }
        .padding()
    }
}

#Preview {
    SpotCardView(spot: SurfSpot(
        id: "1",
        photoURL: "https://example.com/image.jpg",
        destination: "The Bubble",
        destinationState: "Fuerteventura, Canary Islands",
        peakSeasonBegins: "2024-07-22",
        peakSeasonEnds: "2024-08-31",
        surfBreak: ["Reef", "Point Break"],
        difficultyLevel: 4,
        address: "Calle del Mar, 123",
        forecastURL: "https://www.surfline.com/surf-report/pipeline/..."
    ))
}
