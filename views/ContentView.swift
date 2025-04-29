import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
                .frame(height: 300)
        
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text("Reef Break")
                    .font(.title)
                HStack {
                    Text("Pipeline")
                        .font(.body)
                    Spacer()
                    Text("Oahu, Hawaii")
                        .font(.caption)
                }
                
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Divider()


                Text("About Reef Break")
                    .font(.title2)
                    Text("Descriptive text goes here.")
                
            }
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
