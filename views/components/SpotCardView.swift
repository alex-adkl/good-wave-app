//
//  SpotCardView.swift
//  good-wave
//
//  Created by Théo  on 29/04/2025.
//
import SwiftUI

struct SurfSpot: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let location: String
    let dateRange: String
    let rating: Int
    let condition: String
    let forecastURL: String
}

struct SpotCardView: View {
    let spot: SurfSpot

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                AsyncImageView(url: URL(string: spot.imageName), placeholder: "figure.surfing")
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
            HStack {
                Text("\(spot.title) • \(spot.location)")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Text("★ \(spot.rating)")
                    .foregroundColor(.red.opacity(0.7))
            }
            HStack {
                Text(spot.dateRange)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Circle().fill(Color.green).frame(width: 8, height: 8)
                Text(spot.condition.uppercased())
                    .bold()
                    .foregroundColor(.black)
            }

        }
        .padding()
    }
}

#Preview {
    SpotCardView(spot: SurfSpot(
        imageName: "UXSpv5pRxVI8yxQyAPt28tObygpmSCRMaaxsLnfm2Oc",
        title: "Pipeline",
        location: "Oahu, Hawaii",
        dateRange: "22 July - 31 August",
        rating: 4,
        condition: "POOR",
        forecastURL: "https://www.surfline.com/surf-report/pipeline/..."
    ))
}
