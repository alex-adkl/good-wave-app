//
//  SpotCardView.swift
//  good-wave
//
//  Created by Théo  on 29/04/2025.
//

import SwiftUI

struct SpotCardView: View {
    let spot: SurfSpot
    let onToggleSaved: () -> Void

    func colorForDifficulty(_ level: Int) -> Color {
        switch level {
        case 1...2:
            return .green
        case 3:
            return .orange
        case 4...5:
            return .red
        default:
            return .gray
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                AsyncImageView(url: URL(string: spot.photoURL), placeholder: "figure.surfing")
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
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
                    Button(action: {
                        onToggleSaved()
                    }) {
                        Image(systemName: spot.saved ? "heart.fill" : "heart")
                            .foregroundColor(.pink)
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    .padding(10)
                }
            }

            HStack(alignment: .firstTextBaseline) {
                Text("\(spot.destination) • \(spot.location)")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                HStack(spacing: 2) {
                    Text("\(spot.difficultyLevel)")
                        .font(.headline)
                        .foregroundColor(.black)
                    Image(systemName: "star.fill")
                        .foregroundColor(colorForDifficulty(spot.difficultyLevel))
                }
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
        .padding([.leading, .trailing, .bottom])
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
    return SpotCardView(spot: spot, onToggleSaved: {})
}
