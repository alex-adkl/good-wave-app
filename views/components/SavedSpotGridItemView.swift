import SwiftUI

struct SavedSpotGridItemView: View {
    let spot: SurfSpot

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 6) {
                AsyncImageView(url: URL(string: spot.photoURL), placeholder: "figure.surfing")
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .clipped()
                    .cornerRadius(12)
                Text(spot.destination)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 2)
            }
            .padding(.horizontal, 2)
            .padding(.vertical, 4)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    let spot = SurfSpot(
        id: "1",
        photoURL: "https://example.com/image.jpg",
        destination: "The Bubble",
        country: "Fuerteventura, Canary Islands",
        peakSeasonBegins: "2024-07-22",
        peakSeasonEnds: "2024-08-31",
        surfBreak: ["Reef", "Point Break"],
        difficultyLevel: 4,
        address: "Calle del Mar, 123",
        forecastURL: nil,
        geocode: nil,
        saved: true
    )
    return SavedSpotGridItemView(spot: spot)
} 