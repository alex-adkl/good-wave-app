import SwiftUI

struct SpotData {
    let surfBreak: String = "Reef Break"
    let destination: String = "Pipeline"
    let location: String = "Oahu, Hawaii"
    let difficultyLevel: Int = 4
    let seasonStart: String = "22/07"
    let seasonEnd: String = "01/08"
    let forecastURL: String = "https://www.surfline.com/surf-report/pipeline/5842041f4e65fad6a7708890?view=table&camId=58349eed3421b20545c4b56c"
    let imageURL: String = "https://images.unsplash.com/photo-1455264745730-cb3b76250ae8?q=80&w=2233&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
}

struct ContentView: View {
    let spot = SpotData()
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
                CircleImage(url: URL(string: spot.imageURL))
                    .offset(y: -130)
                    .padding(.bottom, -130)
                
                VStack(alignment: .leading) {
                    Text(spot.surfBreak)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        Text(spot.destination)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.blue)
                        Spacer()
                        Text(spot.location)
                            .font(.headline)
                    }
                    
                    Divider()
                    
                    Text("About \(spot.destination)")
                        .font(.title2)
                        .padding(.bottom, 4)
                        .bold()

                    HStack {
                        Text("Difficulty level")
                            .font(.body)
                        Spacer()
                        HStack(spacing: 2) {
                            ForEach(0..<spot.difficultyLevel, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                        .font(.caption)
                    }
                    .padding(.vertical, 0.5)

                    HStack {
                        Text("Peak surf season begins")
                            .font(.body)
                        Spacer()
                        Text(spot.seasonStart)
                            .font(.body)
                    }
                    .padding(.vertical, 0.5)

                    HStack {
                        Text("Peak surf season ends")
                            .font(.body)
                        Spacer()
                        Text(spot.seasonEnd)
                            .font(.body)
                    }
                    .font(.caption)
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
    ContentView()
}
