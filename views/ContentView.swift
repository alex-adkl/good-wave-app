import SwiftUI

struct ContentView: View {
    var difficultyLevel: Int = 4
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
                CircleImage()
                    .offset(y: -130)
                    .padding(.bottom, -130)
                
                VStack(alignment: .leading) {
                    Text("Reef Break")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        Text("Pipeline")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.blue)
                        Spacer()
                        Text("Oahu, Hawaii")
                            .font(.headline)
                    }
                    
                    Divider()
                    
                    Text("About Pipeline")
                        .font(.title2)
                        .padding(.bottom, 4)
                        .bold()

                    HStack {
                        Text("Difficulty level")
                            .font(.body)
                        Spacer()
                        HStack(spacing: 2) {
                            ForEach(0..<difficultyLevel, id: \.self) { _ in
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
                        Text("22/07/2024")
                            .font(.body)
                    }
                    .padding(.vertical, 0.5)

                    HStack {
                        Text("Peak surf season ends")
                            .font(.body)
                        Spacer()
                        Text("31/08/2024")
                            .font(.body)
                    }
                    .font(.caption)
                    .padding(.vertical, 0.5)
                    HStack {
                        Link(destination: URL(string: "https://www.surfline.com/surf-report/pipeline/5842041f4e65fad6a7708890?view=table&camId=58349eed3421b20545c4b56c")!) {
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
